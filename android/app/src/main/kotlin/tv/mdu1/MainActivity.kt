package tv.mdu1.iptv

import android.app.Activity
import android.content.ComponentName
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.os.StrictMode
import android.provider.Settings
import android.view.KeyEvent
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import org.apache.commons.net.ntp.NTPUDPClient
import java.io.DataOutputStream
import java.net.InetAddress
import java.text.SimpleDateFormat


class MainActivity: FlutterActivity(), EventChannel.StreamHandler {
    val CHANNEL = "MDU1Channel"
    lateinit var mduChannel: MethodChannel
    lateinit var channel: EventChannel
    var eventSink: EventChannel.EventSink? = null

    @RequiresApi(Build.VERSION_CODES.O)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        mduChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        mduChannel.setMethodCallHandler {
            call, result ->
                if(call.method == "setTime") {
                    if(android.os.Build.MODEL.equals("stvs2") && !isAutoTimeEnabled(activity)) {
                        val process = Runtime.getRuntime()
                            .exec(arrayOf("su", "-c", "settings put global auto_time 1"))
                        process.waitFor()
                        if (process.exitValue() == 0) {
                            Handler(Looper.getMainLooper()).postDelayed(
                                {
                                    val setOff = Runtime.getRuntime()
                                        .exec(
                                            arrayOf(
                                                "su",
                                                "-c",
                                                "settings put global auto_time 0"
                                            )
                                        )
                                    setOff.waitFor()
                                    val setOn = Runtime.getRuntime()
                                        .exec(
                                            arrayOf(
                                                "su",
                                                "-c",
                                                "settings put global auto_time 1"
                                            )
                                        )
                                    setOn.waitFor()
                                    result.success(true)
                                },
                                5000
                            )
                        } else {
                            result.success(false)
                        }
                    } else {
                        result.success(false)
                    }
                } else if (call.method == "syncTime") {
                    try {
                        val time = call.argument<String>("time");
                        val process = Runtime.getRuntime().exec("su")
                        val os = DataOutputStream(process.outputStream)
                        val command = "date $time\n"
                        os.writeBytes(command)
                        os.flush()
                        os.writeBytes("exit\n")
                        os.flush()
                        process.waitFor()

                        val policy = StrictMode.ThreadPolicy.Builder().permitAll().build()
                        StrictMode.setThreadPolicy(policy)

                        val timeClient = NTPUDPClient()
                        val inetAddress: InetAddress = InetAddress.getByName("time-a.nist.gov")
                        val timeInfo = timeClient.getTime(inetAddress)

                        val parsedTime = SimpleDateFormat("MMddHHmmyy").format(timeInfo.message.receiveTimeStamp.date)
                        val process2 = Runtime.getRuntime().exec("su")
                        val os2 = DataOutputStream(process2.outputStream)
                        val command2 = "date $parsedTime\n"
                        os2.writeBytes(command2)
                        os2.flush()
                        os2.writeBytes("exit\n")
                        os2.flush()
                        process2.waitFor()

                        result.success(true)
                    } catch (e: Throwable) {
                        result.error("Error syncing time", e.message, e.stackTraceToString())
                    }
                } else if (call.method == "openSettings") {
                    try {
                        val name = ComponentName(
                            "com.android.tv.settings",
                            "com.android.tv.settings.MainSettings"
                        )
                        val i = Intent(Intent.ACTION_MAIN)

                        i.addCategory(Intent.CATEGORY_LAUNCHER)
                        i.flags = Intent.FLAG_ACTIVITY_NEW_TASK or
                                Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED
                        i.component = name

                        startActivity(i)

                        result.success(true)
                    } catch(e:Throwable) {
                        result.error("Error opening settings", e.message, e.stackTraceToString())
                    }
                }
        }
        channel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, "tv.mdu1.iptv/keypress")
        channel.setStreamHandler(this)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        mduChannel.invokeMethod("newIntent", intent.action);
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        eventSink?.success(true)

        return super.onKeyDown(keyCode, event)
    }

    override fun dispatchKeyEvent(event: KeyEvent?): Boolean {
        eventSink?.success(true)

        return super.dispatchKeyEvent(event)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    private fun isAutoTimeEnabled(activity: Activity) =
        Settings.Global.getInt(activity.contentResolver, Settings.Global.AUTO_TIME) == 1
}

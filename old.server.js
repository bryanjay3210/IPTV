const express = require("express");

const app = express();
app.use(express.json());

var data = {
  minimum_api_version: "21",
  minimum_app_version: "3.4.0",
  current_version: "3.5.23",
  beta_current_version: "4.0.1",
  download_url: "https://static.safepayhost.com/stb/mdu1-STB-PROD-3.5.23-B116.apk",
  changelog: [
    "To be added",
  ],
  "release_date": "July 26, 2022",
  beta_download_url: "https://static.safepayhost.com/stb/mdu1-STB-PROD-3.5.23-B116.apk",
};

var launcher = {
  minimum_api_version: "21",
  minimum_app_version: "9.0.0",
  current_version: "1.0.17",
  download_url:
    "https://static.safepayhost.com/stb/launcher-STB-PROD-1.0.17.apk",
};

app.get('/apiv2/app/changelog', (req, res) => {
  res.status(200).send({
      "changelog": data['changelog'],
      "release_date": data['release_date']
  });
})

app.post("/apiv2/app/upgrade", (req, res) => {
  if (req.headers["auth"] == undefined) {
    res.status(400).send("Auth header missing");
  }

  var apiVersion = req.body["api_version"];
  var appVersion = req.body["app_version"];
  var isBeta = req.body["fetch_beta"] == "Y";

  if (apiVersion == undefined) {
    res.status(400).send("API version missing");
    return;
  }

  if (appVersion == undefined) {
    res.status(400).send("App version missing");
    return;
  }

  var result = appVersion.localeCompare(data.minimum_app_version, undefined, {
    numeric: true,
    sensitivity: "base",
  });

  if (result == -1) {
    res
      .status(401)
      .send(
        `Minimum app version is greater than your current app version (${appVersion})`
      );
    return;
  }

  var result = appVersion.localeCompare(data.current_version, undefined, {
    numeric: true,
    sensitivity: "base",
  });

  if (result != -1) {
    res.status(404).send({
      "changelog": data['changelog'],
      "release_date": data['release_date']
    });
    return;
  }
  
  if(isBeta) {
    res.send(data["beta_download_url"])
  } else {
    res.send(data["download_url"]);
  }
});

app.post("/apiv2/launcher/upgrade", (req, res) => {
  var apiVersion = req.body["api_version"];
  var appVersion = req.body["app_version"];
  var isBeta = req.body["fetch_beta"] == "Y";

  if (apiVersion == undefined) {
    res.status(400).send("API version missing");
    return;
  }

  if (appVersion == undefined) {
    res.status(400).send("App version missing");
    return;
  }

  var result = appVersion.localeCompare(launcher.minimum_app_version, undefined, {
    numeric: true,
    sensitivity: "base",
  });

  if (result == -1) {
    res
      .status(401)
      .send(
        `Minimum app version is greater than your current app version (${appVersion})`
      );
    return;
  }

  var result = appVersion.localeCompare(launcher.current_version, undefined, {
    numeric: true,
    sensitivity: "base",
  });
  
  if (result != -1) {
    res.status(404).send('You currently have the latest version');
    return;
  }
  
  res.send(launcher["download_url"]);
});

app.listen(3000, () => console.log("OTA server is listening on port 3000."));
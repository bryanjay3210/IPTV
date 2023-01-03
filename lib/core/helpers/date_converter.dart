import 'package:intl/intl.dart';

String dateTimeStringConverter(String date) {
  final year = int.parse(date.substring(0, 4));
  final month = int.parse(date.substring(4, 6));
  final day = int.parse(date.substring(6, 8));
  final hour = int.parse(date.substring(8, 10));
  final minute = int.parse(date.substring(10, 12));

  final dt = DateTime(year, month, day, hour, minute);
  final time = DateFormat.jm();
  final result = '$month/$day/$year ${time.format(dt)}';

  return result;
}

String formatDateTime(DateTime date) {
  return DateFormat('MM/dd/yyyy h:mm aa').format(date);
}

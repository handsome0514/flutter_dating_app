import 'package:intl/intl.dart';

class DatetimeHelper {
  static String formatDate(String date) {
    // Parse the input string into a DateTime object
    var dt = DateTime.parse(date).toLocal();

    // Define the desired output format using DateFormat
    var formatter = DateFormat("dd MMM yyyy, h:mm a");

    // Format the DateTime object according to the formatter
    var dat = formatter.format(dt);

    return dat;
  }

  static String formatDate1(String date) {
    // Parse the input string into a DateTime object
    var dt = DateTime.parse(date).toLocal();

    // Define the desired output format using DateFormat
    var formatter = DateFormat("dd MMM yyyy");

    // Format the DateTime object according to the formatter
    var dat = formatter.format(dt);

    return dat;
  }

  static String formatDateChart(String date) {
    String dateString = "$date";

    var dt = DateTime.parse(dateString).toLocal();

    return DateFormat('MMM yyyy').format(dt);
  }
}

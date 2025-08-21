import 'package:intl/intl.dart';

class MainUtils {

  static String convertToTimeString(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    return DateFormat("hh:mm a").format(parsedTime); // Converts to 12-hour format with AM/PM
  }

}
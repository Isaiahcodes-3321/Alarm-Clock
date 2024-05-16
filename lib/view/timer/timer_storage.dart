import 'package:shared_preferences/shared_preferences.dart';

class StorageTimer {
  static String timerKeyHour = 'timerH';
  static String timerKeyMin = 'timerM';
  static String timerKeySec = 'timerS';
  static String featureTime = 'featureTime';

  static objPre() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}


// import 'package:intl/intl.dart';

                    // Get the current time

                    // DateTime now = DateTime.now();

                    // // Format the time

                    // String formattedTime = DateFormat('HH:mm:ss').format(now);

                    // //output 11:15:22

                    // print('Current time: $formattedTime');

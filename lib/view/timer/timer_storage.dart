import 'package:shared_preferences/shared_preferences.dart';

class StorageTimer {
  static String timerKeyHour = 'timerH';
  static String timerKeyMin = 'timerM';
  static String timerKeySec = 'timerS';
  static String featureTime = 'featureTime';
  static String isTimerSet = 'isTimerSet';
  static String featureTimePeriod = 'featureTimePeriod';

  static objPre() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}




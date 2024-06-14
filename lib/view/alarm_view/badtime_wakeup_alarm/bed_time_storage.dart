import 'package:shared_preferences/shared_preferences.dart';

class StorageBedTime {
  static String showBedTimeKey = 'showBedTimeKey';
  static String bedTimeKeyHr = 'bedTimeKeyHr';
  static String bedTimeKeyMin = 'bedTimeKeyMin';
  static String bedTimeKeyPr = 'bedTimeKeyPr';
  static String wakeTimeKeyHr = 'wakeTimeKeyHr';
  static String wakeTimeKeyMin = 'wakeTimeKeyMin';
  static String wakeTimeKeyPr = 'wakeTimeKeyPr';
  static String mKey = 'mKey';
  static String tKey = 'tKey';
  static String wKey = 'wKey';
  static String thuKey = 'thuKey';
  static String fKey = 'fKey';
  static String satKey = 'satKey';
  static String sunKey = 'sunKey';


  static objPreBedTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
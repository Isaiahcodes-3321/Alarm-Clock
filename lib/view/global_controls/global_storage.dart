import 'package:shared_preferences/shared_preferences.dart';

class AlarmSettingsAudio {
  static String loopAudioKey = 'loopAudio';
  static String vibratingKey = 'vibrating';
  static String alarmVolumeKey = 'vibrateVolumeSt';

  static alarmSettingsObj() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}

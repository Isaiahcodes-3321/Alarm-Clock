import 'nav_export.dart';
import '../alarm_view/view_alarm.dart';



int selectedIndexView = 0;
List<Widget> navViews = [
  const ViewAlarm(),
  const ViewStopWatch(),
  const ViewTimer(),
];

timerSettings() async {
  if (selectedIndexView == 2) {
    final pref = await StorageTimer.objPre();
    final bool? ifTimerIsSet = pref.getBool(StorageTimer.isTimerSet);

    if (ifTimerIsSet == null) {
          //if the timer true or false have not been set
      refProvider.read(isTimerSet.notifier).state = false;
    } else {
      //if the timer true or false its set
      refProvider.read(isTimerSet.notifier).state = ifTimerIsSet;
    }
    GetCurrentTime.isTimerEmpty();
  }
}

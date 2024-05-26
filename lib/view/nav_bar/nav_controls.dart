import 'package:flutter/material.dart';
import 'package:alarm_clock/view/timer/time_view.dart';
import 'package:alarm_clock/view/timer/time_provider.dart';
import 'package:alarm_clock/view/timer/timer_storage.dart';
import 'package:alarm_clock/view/nav_bar/nav_provider.dart';
import 'package:alarm_clock/view/timer/time_controller.dart';
import 'package:alarm_clock/view/alarm_view/view_alarm.dart';
import 'package:alarm_clock/view/stop_watch/stop_watch_view.dart';

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

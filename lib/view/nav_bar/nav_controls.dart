import 'package:flutter/material.dart';
import 'package:alarm_clock/view/timer/time_view.dart';
import 'package:alarm_clock/view/alarm_view/view_alarm.dart';
import 'package:alarm_clock/view/stop_watch/stop_watch_view.dart';

int selectedIndexView = 0;
List<Widget> navViews = [
  const ViewAlarm(),
  const ViewStopWatch(),
  const ViewTimer(),
];

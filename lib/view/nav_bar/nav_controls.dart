import 'package:flutter/material.dart';
import 'package:alarm/view/timer/time_view.dart';
import 'package:alarm/view/alarm_view/view_alarm.dart';
import 'package:alarm/view/stop_watch/stop_watch_view.dart';

int selectedIndexView = 0;
List<Widget> navViews = [
  const ViewAlarm(),
  const ViewStopWatch(),
  const ViewTimer(),
];

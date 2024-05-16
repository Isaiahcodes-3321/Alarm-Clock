import 'package:flutter/material.dart';
import 'package:alarm/view/timer/timer_storage.dart';
import 'package:alarm/view/timer/time_provider.dart';
import 'package:alarm/view/nav_bar/nav_provider.dart';

class TimerInputControls {
  static ifHourInputEmpty() {
    if (InputHolder.hourController.text.isEmpty) {
      refProvider.read(isHourInputEmpty.notifier).state = false;
    } else {
      refProvider.read(isHourInputEmpty.notifier).state = true;
    }
  }

  static ifMinInputEmpty() {
    if (InputHolder.minController.text.isEmpty) {
      refProvider.read(isMinInputEmpty.notifier).state = false;
    } else {
      refProvider.read(isMinInputEmpty.notifier).state = true;
    }
  }

  static ifSecInputEmpty() {
    if (InputHolder.secController.text.isEmpty) {
      refProvider.read(isSecInputEmpty.notifier).state = false;
    } else {
      refProvider.read(isSecInputEmpty.notifier).state = true;
    }
  }
}

class InputHolder {
  static TextEditingController hourController = TextEditingController();
  static TextEditingController minController = TextEditingController();
  static TextEditingController secController = TextEditingController();
}

class GetCurrentTime {
  static isTimerEmpty() async {
    final prefs = await StorageTimer.objPre();
    final int? endTimeHr = prefs.getInt(StorageTimer.timerKeyHour);
    final int? endTimeMin = prefs.getInt(StorageTimer.timerKeyMin);

    if (endTimeHr! > 0 && endTimeMin! > 0) {
      currentTime();
    }
  }

  static currentTime() async {
    final prefs = await StorageTimer.objPre();
    // get the feature time
    final String? getFeatureTime = prefs.getString(StorageTimer.featureTime);
    refProvider.read(featureTime.notifier).state = getFeatureTime!;

    TimeOfDay now = TimeOfDay.now();
    TimeOfDay currentTime = now;
    final int? endTimeHr = prefs.getInt(StorageTimer.timerKeyHour);
    final int? endTimeMin = prefs.getInt(StorageTimer.timerKeyMin);
    final int? endTimeSec = prefs.getInt(StorageTimer.timerKeySec);

    int endTimeConvertHour = 00;

    // check if the current time its greater then 12 in 24 hours format
    if (currentTime.hour >= 12) {
      endTimeConvertHour = currentTime.hour + endTimeHr!;
    }

    // check if the time on storage its empty
    if (endTimeHr != null && endTimeMin != null && endTimeSec != null) {
      TimeOfDay endTime = TimeOfDay(
        hour: endTimeConvertHour,
        minute: endTimeMin,
      );
      if (currentTime.hour > endTime.hour &&
          currentTime.minute > endTime.minute) {
        print('Time is up');
      } else {
        print('Current hour and min $currentTime');
        print('End hour and min $endTime');
        int currentMinutes = currentTime.hour * 60 + currentTime.minute;
        int endMinutes = endTime.hour * 60 + endTime.minute;

        int remainingHourAndMin = endMinutes - currentMinutes;

        // separate the remaining time in hour and minutes
        int remainingHours = remainingHourAndMin ~/ 60;
        int remainingMinutesOnly = remainingHourAndMin % 60;

        final DateTime now = DateTime.now();
        final int currentSec = now.second;
        int getRemainingSec = endTimeSec - currentSec;
        // update the user time on ui
        refProvider.read(intHour.notifier).state = remainingHours;
        refProvider.read(intMin.notifier).state = remainingMinutesOnly;
        refProvider.read(intSec.notifier).state = getRemainingSec;

        print(
            'Remaining time: $remainingHours hours and $remainingMinutesOnly minutes sec $getRemainingSec');
      }
    } else {
      print('you have not set a timer yet');
    }
  }
}

class EmptyTimer {
  static emptyTimer() async {
    final prefs = await StorageTimer.objPre();
    await prefs.setString(StorageTimer.featureTime, '');

    await prefs.setInt(StorageTimer.timerKeyHour, 00);
    await prefs.setInt(StorageTimer.timerKeyMin, 00);
    await prefs.setInt(StorageTimer.timerKeySec, 00);

    refProvider.read(intHour.notifier).state = 00;
    refProvider.read(intMin.notifier).state = 00;
    refProvider.read(intSec.notifier).state = 00;
    refProvider.read(featureTime.notifier).state = "";
  }
}

//     DateTime now = DateTime.now();
//     String currentTime = DateFormat('HH:mm:ss').format(now);

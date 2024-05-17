import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:alarm/view/timer/timer_storage.dart';
import 'package:alarm/view/timer/time_provider.dart';
import 'package:alarm/view/nav_bar/nav_provider.dart';
// ignore_for_file: avoid_print


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
    final pref = await StorageTimer.objPre();
    final int? endTimeHr = pref.getInt(StorageTimer.timerKeyHour);
    final int? endTimeMin = pref.getInt(StorageTimer.timerKeyMin);
    final int? endTimeSec = pref.getInt(StorageTimer.timerKeySec);

    if (endTimeHr! > 0 || endTimeMin! > 0 || endTimeSec! > 0) {
      currentTime();
    } else {
      EmptyTimer.emptyTimer();
      print('no time');
    }
  }

  static currentTime() async {
    TimeOfDay now = TimeOfDay.now();
    final pref = await StorageTimer.objPre();
    // get the feature time
    final String? featureEndTime = pref.getString(StorageTimer.featureTime);
    refProvider.read(featureTime.notifier).state = featureEndTime!;
    final int? endTimeSec = pref.getInt(StorageTimer.timerKeySec);
    // Convert current time to minutes since midnight

    final nowTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      now.hour,
      now.minute,
    );

    final currentTimeString = DateFormat('hh:mm').format(nowTime);

    final currentTime = DateFormat('hh:mm').parse(currentTimeString);
    final endTime = DateFormat('hh:mm').parse(featureEndTime);
    print('current time $currentTimeString');
    print('end time $featureEndTime');

    Duration difference = endTime.difference(currentTime);

    if (difference.isNegative) {
      final endTimeTomorrow = endTime.add(Duration(days: 1));
      difference = endTimeTomorrow.difference(currentTime);
    }

    // Print the remaining time
    final remainingHours = difference.inHours;
    final remainingMinutes = difference.inMinutes.remainder(60);

    //calculate sec
    final DateTime secNow = DateTime.now();
    final int currentSec = secNow.second;
    int getRemainingSec = endTimeSec! - currentSec;
    refProvider.read(intHour.notifier).state = remainingHours;
    refProvider.read(intMin.notifier).state = remainingMinutes;
    refProvider.read(intSec.notifier).state = getRemainingSec;

    print('current sec $getRemainingSec');
    print(
        'Remaining time: $remainingHours hours and $remainingMinutes minutes');
  }
}

class EmptyTimer {
  static emptyTimer() async {
    final pref = await StorageTimer.objPre();
    await pref.setString(StorageTimer.featureTime, '');

    await pref.setInt(StorageTimer.timerKeyHour, 00);
    await pref.setInt(StorageTimer.timerKeyMin, 00);
    await pref.setInt(StorageTimer.timerKeySec, 00);

    refProvider.read(intHour.notifier).state = 00;
    refProvider.read(intMin.notifier).state = 00;
    refProvider.read(intSec.notifier).state = 00;
    refProvider.read(featureTime.notifier).state = "";
    refProvider.read(featureTimePeriod.notifier).state = "";
  }
}

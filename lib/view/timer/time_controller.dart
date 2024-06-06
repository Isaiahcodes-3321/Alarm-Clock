import 'time_export.dart';
import 'package:flutter/material.dart';

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
      print('time $endTimeSec');
      currentTime();
    } else {
      EmptyTimer.emptyTimer();
      print('no time');
    }
  }

  static currentTime() async {
    TimeOfDay now = TimeOfDay.now();
    final pref = await StorageTimer.objPre();
    // get the feature time and period
    final String? featureEndTime = pref.getString(StorageTimer.featureTime);
    final String? getFeatureTimePe =
        pref.getString(StorageTimer.featureTimePeriod);
    refProvider.read(featureTime.notifier).state = featureEndTime!;
    refProvider.read(featureTimePeriod.notifier).state = getFeatureTimePe!;

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

    // Convert times to integer representation (in minutes since midnight)
    int intCurrentTime = currentTime.hour * 60 + currentTime.minute;
    int intEndTime = endTime.hour * 60 + endTime.minute;
    if (intCurrentTime > intEndTime) {
      EmptyTimer.emptyTimer();
      showNotification();
      print('Current time is greater than end time.');
    } else {
      print('Current time is not greater than end time.');

      Duration difference = endTime.difference(currentTime);

      if (difference.isNegative) {
        final endTimeTomorrow = endTime.add(const Duration(days: 1));
        difference = endTimeTomorrow.difference(currentTime);
      }

      // get the remaining time
      final remainingHours = difference.inHours;
      final remainingMinutes = difference.inMinutes.remainder(60);

      //calculate sec
      final DateTime secNow = DateTime.now();
      final int currentSec = secNow.second;
      int getRemainingSec = endTimeSec! - currentSec;

      refProvider.read(intHour.notifier).state = remainingHours;
      refProvider.read(intMin.notifier).state = remainingMinutes;
      refProvider.read(intSec.notifier).state = getRemainingSec;
      print(
          'Remaining time:  hours $remainingHours minutes $remainingMinutes sec $getRemainingSec');
    }
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

    await pref.setBool(StorageTimer.isTimerSet, false);
    final bool? ifTimerIsSet = pref.getBool(StorageTimer.isTimerSet);
    refProvider.read(isTimerSet.notifier).state = ifTimerIsSet!;
  }
}

int alarmId = 1;

final alarmSettings = AlarmSettings(
  id: alarmId,
  dateTime: DateTime(2024, 5, 23, 0, 0, 0),
  assetAudioPath: 'assets/app_music/Majeeed_Ft_Lojay_-_Cry_shayo_.mp3',
  loopAudio: refProvider.watch(isLoopAudio),
  vibrate: refProvider.watch(isVibrating),
  volume: refProvider.watch(vibrateVolume),
  fadeDuration: 3.0,
  notificationTitle: '',
  notificationBody: '00 : 00 : 00',
  enableNotificationOnKill: Platform.isIOS,
  androidFullScreenIntent: true,
);

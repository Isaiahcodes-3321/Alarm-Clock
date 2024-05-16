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
  static currentTime() async {
    final prefs = await StorageTimer.objPre();

    TimeOfDay now = TimeOfDay.now();
    TimeOfDay currentTime = now;

    final int? endTimeHr = prefs.getInt(StorageTimer.timerKeyHour);
    final int? endTimeMin = prefs.getInt(StorageTimer.timerKeyMin);
    final int? endTimeSec = prefs.getInt(StorageTimer.timerKeySec);

    int endTimeConvertHour = 00;

    if (currentTime.hour >= 12) {
      endTimeConvertHour = currentTime.hour + endTimeHr!;
    }

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
        int remainingHours = remainingHourAndMin ~/ 60;
        int remainingMinutesOnly = remainingHourAndMin % 60;
        final DateTime now = DateTime.now();
        final int currentSec = now.second;
        int getRemainingSec = endTimeSec - currentSec;
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



// class GetCurrentTime {
//   static currentTime() async {
//     final prefs = await StorageTimer.objPre();

//     DateTime now = DateTime.now();
//     String currentTime = DateFormat('HH:mm:ss').format(now);


//     final int? hr = prefs.getInt(StorageTimer.timerKeyHour);
//     final int? ms = prefs.getInt(StorageTimer.timerKeyMin);
//     final int? ss = prefs.getInt(StorageTimer.timerKeySec);

//     String endTime = "$hr:$ms:$ss";
    
//     print('min its $currentTime');
//     print('min itsssss $endTime');

//     // if(currentTime > endTime){
//     //  print('time is up');
//     // }
//   }
// }

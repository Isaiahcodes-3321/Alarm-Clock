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

    final int? hr = prefs.getInt(StorageTimer.timerKeyHour);
    final int? ms = prefs.getInt(StorageTimer.timerKeyMin);
    final int? ss = prefs.getInt(StorageTimer.timerKeySec);

    if (hr != null && ms != null && ss != null) {
      TimeOfDay endTime = TimeOfDay(hour: hr, minute: ms);

      print('Current time: $currentTime');
      print('End time: $endTime');

      if (currentTime.hour > endTime.hour &&
          currentTime.minute > endTime.minute) {
        print('Time is up');
      }
    } else {
      print('you still have some time ');
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

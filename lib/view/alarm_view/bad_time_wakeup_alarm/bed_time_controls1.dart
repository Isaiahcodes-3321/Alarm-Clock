import 'bed_time_export.dart';
import 'package:intl/intl.dart';
import 'package:alarm_clock/themes/constant.dart';
import 'package:alarm_clock/widgets/notification.dart';
import 'package:alarm_clock/view/global_controls/global_provider.dart';

class ControlsRingAlarm {
  static checkingSleepTime() {
    DateTime now = DateTime.now();
    String currentTime = DateFormat('hh:mm a').format(now);
    String currentDay = DateFormat('EEE').format(now);
    if (refProvider.watch(displayBedTimeHr) == 0) {
    } else {
      String getStoredBedTime =
          '${refProvider.watch(displayBedTimeHr)}:${refProvider.watch(displayBedTimeMin)} ${refProvider.watch(displayBedTimePr)}';
      // Parsing the saved time into DateTime object
      DateTime savedDateBedTime = DateFormat('hh:mm a').parse(getStoredBedTime);
      // Formatting the saved DateTime object to ensure it's in the same format as current time
      String savedBedTimeFormatted =
          DateFormat('hh:mm a').format(savedDateBedTime);

      print('save sleep time $savedBedTimeFormatted');
      print('Current sleep time: $currentTime');
      //

      if (currentTime == savedBedTimeFormatted) {
        if (currentDay == refProvider.watch(setMonText) ||
            currentDay == refProvider.watch(setTueText) ||
            currentDay == refProvider.watch(setWedText) ||
            currentDay == refProvider.watch(setThuText) ||
            currentDay == refProvider.watch(setFriText) ||
            currentDay == refProvider.watch(setSatText) ||
            currentDay == refProvider.watch(setSunText)) {
          refProvider.watch(isNotificationClick)
              ? durationSeconds(50, () {
                  print('vvv now 11 ${refProvider.watch(isNotificationClick)}');
                  refProvider.read(isNotificationClick.notifier).state = false;
                  ControlsRingAlarm.checkingSleepTime();
                })
              : showSleepNotificationAlarm();
          durationMin(3, () {
            ControlsRingAlarm.checkingSleepTime();
          });
        }
      } else {
        durationSeconds(5, () {
           refProvider.read(isNotificationClick.notifier).state = false;
            // print('vvv now cvvc ${refProvider.watch(isNotificationClick)}');
          ControlsRingAlarm.checkingSleepTime();
        });
        print('run bed time again');
      }
    }
  }

  static checkingWakeTime() {
    DateTime now = DateTime.now();
    String currentTime = DateFormat('hh:mm a').format(now);
    String currentDay = DateFormat('EEE').format(now);
    if (refProvider.watch(displayWakeTimeHr) == 0) {
    } else {
      String getStoredWakeTime =
          '${refProvider.watch(displayWakeTimeHr)}:${refProvider.watch(displayWakeTimeMin)} ${refProvider.watch(displayWakeTimePr)}';
      // Parsing the saved time into DateTime object
      DateTime savedDateWakeTime =
          DateFormat('hh:mm a').parse(getStoredWakeTime);
      // Formatting the saved DateTime object to ensure it's in the same format as current time
      String savedWakeTimeFormatted =
          DateFormat('hh:mm a').format(savedDateWakeTime);

      print('save wake time $savedWakeTimeFormatted');
      print('Current wake time: $currentTime');
      //

      if (currentTime == savedWakeTimeFormatted) {
        if (currentDay == refProvider.watch(setMonText) ||
            currentDay == refProvider.watch(setTueText) ||
            currentDay == refProvider.watch(setWedText) ||
            currentDay == refProvider.watch(setThuText) ||
            currentDay == refProvider.watch(setFriText) ||
            currentDay == refProvider.watch(setSatText) ||
            currentDay == refProvider.watch(setSunText)) {
          refProvider.watch(isNotificationClick)
              ? durationSeconds(50, () {
                  print('waiting wake time now ${refProvider.watch(isNotificationClick)}');
                  refProvider.read(isNotificationClick.notifier).state = false;
                  ControlsRingAlarm.checkingWakeTime();
                })
              : showWakeNotificationAlarm();
          durationMin(3, () {
            ControlsRingAlarm.checkingWakeTime();
          });
        }
      } else {
        durationSeconds(5, () {
           refProvider.read(isNotificationClick.notifier).state = false;
          ControlsRingAlarm.checkingWakeTime();
        });
        print('run wake time again');
      }
    }
  }
}

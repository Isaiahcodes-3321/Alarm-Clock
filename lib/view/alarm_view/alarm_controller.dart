import 'package:intl/intl.dart';
import 'package:alarm_clock/themes/constant.dart';
import 'package:alarm_clock/widgets/navigation.dart';
import 'package:alarm_clock/widgets/notification.dart';
import 'package:alarm_clock/view/alarm_view/alarm_export.dart';
import 'package:alarm_clock/view/global_controls/global_provider.dart';
import 'package:alarm_clock/view/alarm_view/display_alarm_list/list_alarm_controlls.dart';

class AlarmControllers {
  static DateTime selectedDate = DateTime.now();
  static displayDatePiker() async {
    BuildContext context = navigateKey.currentContext!;
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      DateFormat dateFormat = DateFormat('EEE d MMM');
      String formattedDate = dateFormat.format(selectedDate);
      refProvider.read(isCalenderDatePicked.notifier).state = true;

      refProvider.read(dateSelectedOnCalender.notifier).state = formattedDate;

      print('Selected date: $formattedDate');
    }
  }
}

class RingAlarmControls {
  static checkingTime() {
    DateTime now = DateTime.now();

    String currentTime = DateFormat('hh:mm a').format(now);
    String currentDay = DateFormat('EEE').format(now);

    for (int index = 0; index < items.length; index++) {
      String getStoredTime = "${items[index][0]} ${items[index][1]}";
      // Parsing the saved time into DateTime object
      DateTime savedDateTime = DateFormat('hh:mm a').parse(getStoredTime);
      // Formatting the saved DateTime object to ensure it's in the same format as current time
      String savedTimeFormatted = DateFormat('hh:mm a').format(savedDateTime);

      // print('save time $savedTimeFormatted');
      // print('Current time: $currentTime');
      //
      String getStoredM = items[index][2];
      String getStoredT = items[index][3];
      String getStoredW = items[index][4];
      String getStoredTh = items[index][5];
      String getStoredF = items[index][6];
      String getStoredSat = items[index][7];
      // getStoredSun its still holding the date and month if user set it from calender
      String getStoredSun = items[index][8];
      // Parsing the stored date:

      if (currentTime == savedTimeFormatted) {
        if (currentDay == getStoredM ||
            currentDay == getStoredT ||
            currentDay == getStoredW ||
            currentDay == getStoredTh ||
            currentDay == getStoredF ||
            currentDay == getStoredSat ||
            currentDay == getStoredSun) {
          refProvider.watch(isNotificationClick)
              ? durationMin(1, () {
                  refProvider.read(isNotificationClick.notifier).state = false;
                  RingAlarmControls.checkingTime();
                })
              : showNotificationAlarm();
          durationMin(3, () {
            RingAlarmControls.checkingTime();
          });
          // print('one of the day its same oooo');
        } else {
          // convert the date that the user picked from the calender
          String currentDateString = DateFormat('EEE dd MMM').format(now);
          print('Save date 000 $getStoredSun');
          print("current date 0001 $currentDateString");
          if (currentDateString == getStoredSun) {
            refProvider.watch(isNotificationClick)
                ? durationSeconds(50, () {
                    print('waiting alarm now ${refProvider.watch(isNotificationClick)}');

                    refProvider.read(isNotificationClick.notifier).state =
                        false;
                    RingAlarmControls.checkingTime();
                  })
                : showNotificationAlarm();
            durationMin(3, () {
              RingAlarmControls.checkingTime();
            });
          } else {
            durationSeconds(5, () {
              refProvider.read(isNotificationClick.notifier).state = false;
              RingAlarmControls.checkingTime();
            });
            // print('Saved date on calender its not same with current date');
          }
        }
      } else {
        print('Current time its not same with save time');
        durationSeconds(5, () {
          refProvider.read(isNotificationClick.notifier).state = false;
          RingAlarmControls.checkingTime();
        });
        // print('run again');
      }
    }
  }
}

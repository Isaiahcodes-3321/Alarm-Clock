import '../alarm_export.dart';
import 'package:alarm_clock/widgets/navigation.dart';
import 'package:alarm_clock/widgets/show_snackbar.dart';
import 'package:alarm_clock/view/nav_bar/nav_view.dart';
import 'package:alarm_clock/view/alarm_view/display_alarm_list/list_alarm_controlls.dart';

int alarmSelectedHourIndex = 0;
int alarmSelectedMinuteIndex = 0;
int alarmSelectedPeriodIndex = 0;

final now = TimeOfDay.now();
final alarmHoursWheel = WheelPickerController(
  itemCount: 12,
  initialIndex: (now.hour % 12) - 1,
);
final alarmMinutesWheel = WheelPickerController(
  itemCount: 60,
  initialIndex: now.minute - 1,
  mounts: [alarmHoursWheel],
);
final alarmPeriodWheel = WheelPickerController(
  itemCount: 2,
  initialIndex: (now.period == DayPeriod.am) ? 0 : 1,
);

void printSelectedHour() {
  final hour = (alarmSelectedHourIndex + 1) % 12;
  // refProvider.read(selectedHour.notifier).state = hour;
  refProvider.read(selectedHour.notifier).state =
      int.parse("${hour == 0 ? 12 : hour}");
  print("Selected alarm hour: ${hour == 0 ? 12 : hour}");
}

void printSelectedMinute() {
  final minute = alarmSelectedMinuteIndex + 1;
  refProvider.read(selectedMin.notifier).state = minute;
  print("Selected alarm minute: $minute");
}

void printSelectedPeriod() {
  final period = alarmSelectedPeriodIndex == 0 ? "AM" : "PM";
  refProvider.read(selectedPeriod.notifier).state = period;
  print("Selected alarm period: $period");
}

class SettingAlarmControls {
  static ifDayNotSet() {
    if (refProvider.watch(isCalenderDatePicked)) {
      printSelectedHour();
      printSelectedMinute();
      printSelectedPeriod();
      // isDayPick();
      addItem();
      const Duration(seconds: 1);
      navigateTo(const HomeView());
    } else {
      if (refProvider.watch(isM) ||
          refProvider.watch(isT) ||
          refProvider.watch(isW) ||
          refProvider.watch(isThr) ||
          refProvider.watch(isF) ||
          refProvider.watch(isSat) ||
          refProvider.watch(isSun)) {
        printSelectedHour();
        printSelectedMinute();
        printSelectedPeriod();
        isDayPick();
        addItem();
        const Duration(seconds: 1);
        navigateTo(const HomeView());
      } else {
        BuildContext context = navigateKey.currentContext!;
        showCustomSnackBar(context, 'You have not pick a day!');
      }
    }
  }

  // check if any of the day its picked
  static isDayPick() {
    if (refProvider.watch(isM) ||
        refProvider.watch(isT) ||
        refProvider.watch(isW) ||
        refProvider.watch(isThr) ||
        refProvider.watch(isF) ||
        refProvider.watch(isSat) ||
        refProvider.watch(isSun)) {
      refProvider.read(isCalenderDatePicked.notifier).state = false;
      refProvider.read(isAnyDayPick.notifier).state = true;
    } else {
      refProvider.read(isAnyDayPick.notifier).state = false;
    }

    if (refProvider.watch(isM) &&
        refProvider.watch(isT) &&
        refProvider.watch(isW) &&
        refProvider.watch(isThr) &&
        refProvider.watch(isF) &&
        refProvider.watch(isSat) &&
        refProvider.watch(isSun)) {
      refProvider.read(allDaysSelected.notifier).state = 'Day';
      refProvider.read(monText.notifier).state = '';
      refProvider.read(tueText.notifier).state = '';
      refProvider.read(wedText.notifier).state = '';
      refProvider.read(thrText.notifier).state = '';
      refProvider.read(friText.notifier).state = '';
      refProvider.read(satText.notifier).state = '';
      refProvider.read(sunText.notifier).state = '';
    } else {
      refProvider.read(allDaysSelected.notifier).state = '';

      // if a particular day is selected
      if (refProvider.watch(isM)) {
        refProvider.read(monText.notifier).state = 'Mon';
      } else {
        refProvider.read(monText.notifier).state = '';
      }
      if (refProvider.watch(isT)) {
        refProvider.read(tueText.notifier).state = 'Tue';
      } else {
        refProvider.read(tueText.notifier).state = '';
      }
      if (refProvider.watch(isW)) {
        refProvider.read(wedText.notifier).state = 'Wed';
      } else {
        refProvider.read(wedText.notifier).state = '';
      }
      if (refProvider.watch(isThr)) {
        refProvider.read(thrText.notifier).state = 'Thu';
      } else {
        refProvider.read(thrText.notifier).state = '';
      }
      if (refProvider.watch(isF)) {
        refProvider.read(friText.notifier).state = 'Fri';
      } else {
        refProvider.read(friText.notifier).state = '';
      }
      if (refProvider.watch(isSat)) {
        refProvider.read(satText.notifier).state = 'Sat';
      } else {
        refProvider.read(satText.notifier).state = '';
      }
      if (refProvider.watch(isSun)) {
        refProvider.read(sunText.notifier).state = 'Sun';
      } else {
        refProvider.read(sunText.notifier).state = '';
      }
    }

    print('iff ${refProvider.watch(isAnyDayPick)}');
  }
}

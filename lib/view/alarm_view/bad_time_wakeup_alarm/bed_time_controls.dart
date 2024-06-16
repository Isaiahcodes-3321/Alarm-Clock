import '../alarm_export.dart';
import 'package:alarm_clock/widgets/navigation.dart';
import 'package:alarm_clock/view/nav_bar/nav_view.dart';
import 'package:alarm_clock/widgets/show_snackbar.dart';
import 'package:alarm_clock/view/alarm_view/bad_time_wakeup_alarm/bed_time_storage.dart';
import 'package:alarm_clock/view/alarm_view/bad_time_wakeup_alarm/bed_time_provider.dart';

class BedTimePicker {
  static int bedTimeSelectedHourIndex = 0;
  static int bedTimeSelectedMinuteIndex = 0;
  static int bedTimeSelectedPeriodIndex = 0;

  static final now = TimeOfDay.now();
  static final bedTimeHoursWheel = WheelPickerController(
    itemCount: 12,
    initialIndex: (now.hour % 12) - 1,
  );
  static final bedTimeMinutesWheel = WheelPickerController(
    itemCount: 60,
    initialIndex: now.minute - 1,
    mounts: [bedTimeHoursWheel],
  );
  static final bedTimePeriodWheel = WheelPickerController(
    itemCount: 2,
    initialIndex: (now.period == DayPeriod.am) ? 0 : 1,
  );

  static void printBedTimeSelectedHour() {
    final hour = (bedTimeSelectedHourIndex + 1) % 12;
    refProvider.read(bedTimeSelectedHour.notifier).state = hour;
    printBedTimeSelectedPeriod();
    GetSleepingPeriod.getSleepingPeriod();
    print("Selected bed time hour: ${hour == 0 ? 12 : hour}");
  }

  static void printBedTimeSelectedMinute() {
    final minute = bedTimeSelectedMinuteIndex + 1;
    refProvider.read(bedTimeSelectedMin.notifier).state = minute;
    printBedTimeSelectedPeriod();
    GetSleepingPeriod.getSleepingPeriod();
    print("Selected bed time minute: $minute");
  }

  static void printBedTimeSelectedPeriod() {
    final period = bedTimeSelectedPeriodIndex == 0 ? "AM" : "PM";
    refProvider.read(bedTimeSelectedPeriod.notifier).state = period;
    GetSleepingPeriod.getSleepingPeriod();
    print("Selected bed time period: $period");
  }
}

class WakeUpTimePicker {
  static int wakeTimeSelectedHourIndex = 0;
  static int wakeTimeSelectedMinuteIndex = 0;
  static int wakeTimeSelectedPeriodIndex = 0;

  static final now = TimeOfDay.now();
  static final wakeTimeHoursWheel = WheelPickerController(
    itemCount: 12,
    initialIndex: (now.hour % 12) - 1,
  );
  static final wakeTimeMinutesWheel = WheelPickerController(
    itemCount: 60,
    initialIndex: now.minute - 1,
    mounts: [wakeTimeHoursWheel],
  );
  static final wakeTimePeriodWheel = WheelPickerController(
    itemCount: 2,
    initialIndex: (now.period == DayPeriod.am) ? 0 : 1,
  );

  static void printWakeTimeSelectedHour() {
    final hour = (wakeTimeSelectedHourIndex + 1) % 12;
    refProvider.read(wakeTimeSelectedHour.notifier).state = hour;
    printWakeTimeSelectedPeriod();
    GetSleepingPeriod.getSleepingPeriod();
    print("Selected  wake up time hour: ${hour == 0 ? 12 : hour}");
  }

  static void printWakeTimeSelectedMinute() {
    final minute = wakeTimeSelectedMinuteIndex + 1;
    refProvider.read(wakeTimeSelectedMin.notifier).state = minute;
    printWakeTimeSelectedPeriod();
    GetSleepingPeriod.getSleepingPeriod();
    print("Selected  wake up time minute: $minute");
  }

  static void printWakeTimeSelectedPeriod() {
    final period = wakeTimeSelectedPeriodIndex == 0 ? "AM" : "PM";
    refProvider.read(wakeTimeSelectedPeriod.notifier).state = period;
    GetSleepingPeriod.getSleepingPeriod();
    print("Selected wake up time  period: $period");
  }
}

class GetSleepingPeriod {
  static getAllTime() {
    BedTimePicker.printBedTimeSelectedHour();
    BedTimePicker.printBedTimeSelectedMinute();
    WakeUpTimePicker.printWakeTimeSelectedHour();
    WakeUpTimePicker.printWakeTimeSelectedMinute();
  }

  static getSleepingPeriod() {
    int getBedTimeHour = refProvider.watch(bedTimeSelectedHour);
    int getBedTimeMin = refProvider.watch(bedTimeSelectedMin);
    String getBedTimePeriod = refProvider.watch(bedTimeSelectedPeriod);

    int getWakeUpTimeHour = refProvider.watch(wakeTimeSelectedHour);
    int getWakeUpTimeMin = refProvider.watch(wakeTimeSelectedMin);
    String getWakeUpTimePeriod = refProvider.watch(wakeTimeSelectedPeriod);

    // Convert 12-hour format to 24-hour format
    int bedTimeHour24 = getBedTimePeriod == "PM" && getBedTimeHour != 12
        ? getBedTimeHour + 12
        : (getBedTimePeriod == "AM" && getBedTimeHour == 12
            ? 0
            : getBedTimeHour);
    int wakeUpTimeHour24 =
        getWakeUpTimePeriod == "PM" && getWakeUpTimeHour != 12
            ? getWakeUpTimeHour + 12
            : (getWakeUpTimePeriod == "AM" && getWakeUpTimeHour == 12
                ? 0
                : getWakeUpTimeHour);

    // Calculate total minutes from midnight for both times
    int bedTimeInMinutes = bedTimeHour24 * 60 + getBedTimeMin;
    int wakeUpTimeInMinutes = wakeUpTimeHour24 * 60 + getWakeUpTimeMin;

    // Calculate the difference in minutes
    int sleepingMinutes;
    if (wakeUpTimeInMinutes >= bedTimeInMinutes) {
      sleepingMinutes = wakeUpTimeInMinutes - bedTimeInMinutes;
    } else {
      // If wake-up time falls on the next day
      sleepingMinutes = (1440 - bedTimeInMinutes) + wakeUpTimeInMinutes;
    }

    // Convert minutes to hours and minutes
    int sleepingHours = sleepingMinutes ~/ 60;
    int sleepingRemainingMinutes = sleepingMinutes % 60;

    refProvider.read(sleepingPeriodHour.notifier).state = sleepingHours;
    refProvider.read(sleepingPeriodMin.notifier).state =
        sleepingRemainingMinutes;

    // Print the sleeping period
    // print(
    //     'Sleeping period: $sleepingHours hours and $sleepingRemainingMinutes minutes');
  }
}

class SaveBedTime {
  // before user save the sleep time check if user picked any day
  static ifDayNotSet() {
    if (refProvider.watch(isBedTimeM) ||
        refProvider.watch(isBedTimeT) ||
        refProvider.watch(isBedTimeW) ||
        refProvider.watch(isBedTimeThr) ||
        refProvider.watch(isBedTimeF) ||
        refProvider.watch(isBedTimeSat) ||
        refProvider.watch(isBedTimeSun)) {
      // calling this 4 function have to be a step by step way
      GetSleepingPeriod.getAllTime();
      SaveBedTime.isBedSetTrue();
      SaveBedTime.saveInfoBedTime();
      SaveBedTime.saveInfoWakeTime();
    } else {
      BuildContext context = navigateKey.currentContext!;
      showCustomSnackBar(context, 'You have not pick a day!');
    }
  }

  // set the visibility of bedtime listView if user have set it already
  static isBedSetTrue() async {
    final pref = await StorageBedTime.objPreBedTime();
    await pref.setBool(StorageBedTime.showBedTimeKey, true);
  }

  static saveInfoBedTime() async {
    final pref = await StorageBedTime.objPreBedTime();

    if (refProvider.watch(isBedTimeM)) {
      await pref.setString(StorageBedTime.mKey, 'MON');
      await pref.setBool(StorageBedTime.isMSelectedKey, true);
    } else {
      refProvider.read(setMonText.notifier).state = '';
    }
    //
    if (refProvider.watch(isBedTimeT)) {
      await pref.setString(StorageBedTime.tKey, 'TUE');
      await pref.setBool(StorageBedTime.isTSelectedKey, true);
    } else {
      refProvider.read(setTueText.notifier).state = '';
    }
    //
    if (refProvider.watch(isBedTimeW)) {
      await pref.setString(StorageBedTime.wKey, 'WED');
      await pref.setBool(StorageBedTime.isWSelectedKey, true);
    } else {
      refProvider.read(setWedText.notifier).state = '';
    }
    if (refProvider.watch(isBedTimeThr)) {
      await pref.setString(StorageBedTime.thuKey, 'THU');
      await pref.setBool(StorageBedTime.isThuSelectedKey, true);
    } else {
      refProvider.read(setThuText.notifier).state = '';
    }
    if (refProvider.watch(isBedTimeF)) {
      await pref.setString(StorageBedTime.fKey, 'FRI');
      await pref.setBool(StorageBedTime.isFSelectedKey, true);
    } else {
      refProvider.read(setFriText.notifier).state = '';
    }
    if (refProvider.watch(isBedTimeSat)) {
      await pref.setString(StorageBedTime.satKey, 'SAT');
      await pref.setBool(StorageBedTime.isSatSelectedKey, true);
    } else {
      refProvider.read(setSatText.notifier).state = '';
    }
    if (refProvider.watch(isBedTimeSun)) {
      await pref.setString(StorageBedTime.sunKey, 'SUN');
      await pref.setBool(StorageBedTime.isSunSelectedKey, true);
    } else {
      refProvider.read(setSunText.notifier).state = '';
    }
    const Duration(seconds: 1);
    navigateTo(const HomeView());
    // call wake up time and bed time to update the screen before navigating
    WakeUpTime.ifBedTimeIsTrue();
  }

  static saveInfoWakeTime() async {
    final pref = await StorageBedTime.objPreBedTime();
    await pref.setInt(
        StorageBedTime.bedTimeKeyHr, refProvider.watch(bedTimeSelectedHour));
    await pref.setInt(
        StorageBedTime.bedTimeKeyMin, refProvider.watch(bedTimeSelectedMin));
    await pref.setString(
        StorageBedTime.bedTimeKeyPr, refProvider.watch(bedTimeSelectedPeriod));

    // wake up time
    await pref.setInt(
        StorageBedTime.wakeTimeKeyHr, refProvider.watch(wakeTimeSelectedHour));
    await pref.setInt(
        StorageBedTime.wakeTimeKeyMin, refProvider.watch(wakeTimeSelectedMin));
    await pref.setString(StorageBedTime.wakeTimeKeyPr,
        refProvider.watch(wakeTimeSelectedPeriod));
  }
}

// if the bedtime have been set buy user call this to display the sleep time info
class WakeUpTime {
  static ifBedTimeIsTrue() async {
    final pref = await StorageBedTime.objPreBedTime();
    final bool? getBedTimeTrueValue =
        pref.getBool(StorageBedTime.showBedTimeKey);
    refProvider.read(isBedSet.notifier).state = getBedTimeTrueValue;
    // get bedtime and wake up time
    final int? getBedTimeHr = pref.getInt(StorageBedTime.bedTimeKeyHr);
    final int? getBedTimeMin = pref.getInt(StorageBedTime.bedTimeKeyMin);
    final String? getBedTimePer = pref.getString(StorageBedTime.bedTimeKeyPr);
    // get wake up time
    final int? getWakeTimeHr = pref.getInt(StorageBedTime.wakeTimeKeyHr);
    final int? getWakeTimeMin = pref.getInt(StorageBedTime.wakeTimeKeyMin);
    final String? getWakeTimePer = pref.getString(StorageBedTime.wakeTimeKeyPr);

    // update provider to display bed time to user
    refProvider.read(displayBedTimeHr.notifier).state = getBedTimeHr;
    refProvider.read(displayBedTimeMin.notifier).state = getBedTimeMin;
    refProvider.read(displayBedTimePr.notifier).state = getBedTimePer;

    /// update provider to display the saved bedtime and wake up time
    refProvider.read(displayWakeTimeHr.notifier).state = getWakeTimeHr;
    refProvider.read(displayWakeTimeMin.notifier).state = getWakeTimeMin;
    refProvider.read(displayWakeTimePr.notifier).state = getWakeTimePer;

    // get days selected
    final bool? getDaySelectedM = pref.getBool(StorageBedTime.isMSelectedKey);
    final bool? getDaySelectedT = pref.getBool(StorageBedTime.isTSelectedKey);
    final bool? getDaySelectedW = pref.getBool(StorageBedTime.isWSelectedKey);
    final bool? getDaySelectedThu =
        pref.getBool(StorageBedTime.isThuSelectedKey);
    final bool? getDaySelectedF = pref.getBool(StorageBedTime.isFSelectedKey);
    final bool? getDaySelectedSat =
        pref.getBool(StorageBedTime.isSatSelectedKey);
    final bool? getDaySelectedSun =
        pref.getBool(StorageBedTime.isSunSelectedKey);

    // update the providers holding the days saved
    refProvider.read(isBedTimeM.notifier).state = getDaySelectedM;
    refProvider.read(isBedTimeT.notifier).state = getDaySelectedT;
    refProvider.read(isBedTimeW.notifier).state = getDaySelectedW;
    refProvider.read(isBedTimeThr.notifier).state = getDaySelectedThu;
    refProvider.read(isBedTimeF.notifier).state = getDaySelectedF;
    refProvider.read(isBedTimeSat.notifier).state = getDaySelectedSat;
    refProvider.read(isBedTimeSun.notifier).state = getDaySelectedSun;

    // get the days saved
    final String? getTextDaySavedM = pref.getString(StorageBedTime.mKey);
    final String? getTextDaySavedT = pref.getString(StorageBedTime.tKey);
    final String? getTextDaySavedW = pref.getString(StorageBedTime.wKey);
    final String? getTextDaySavedThu = pref.getString(StorageBedTime.thuKey);
    final String? getTextDaySavedF = pref.getString(StorageBedTime.fKey);
    final String? getTextDaySavedSat = pref.getString(StorageBedTime.satKey);
    final String? getTextDaySavedSun = pref.getString(StorageBedTime.sunKey);

    // update the providers displaying saved days
    refProvider.read(setMonText.notifier).state = getTextDaySavedM;
    refProvider.read(setTueText.notifier).state = getTextDaySavedT;
    refProvider.read(setWedText.notifier).state = getTextDaySavedW;
    refProvider.read(setThuText.notifier).state = getTextDaySavedThu;
    refProvider.read(setFriText.notifier).state = getTextDaySavedF;
    refProvider.read(setSatText.notifier).state = getTextDaySavedSat;
    refProvider.read(setSunText.notifier).state = getTextDaySavedSun;
  }
}

class ClearBedTime {
  static emptyStorage() async {
    final pref = await StorageBedTime.objPreBedTime();
    await pref.setBool(StorageBedTime.showBedTimeKey, false);
    refProvider.read(isBedSet.notifier).state = false;
//
    await pref.setString(StorageBedTime.mKey, '');
    await pref.setString(StorageBedTime.tKey, '');
    await pref.setString(StorageBedTime.wKey, '');
    await pref.setString(StorageBedTime.thuKey, '');
    await pref.setString(StorageBedTime.fKey, '');
    await pref.setString(StorageBedTime.satKey, '');
    await pref.setString(StorageBedTime.sunKey, '');

    //
    refProvider.read(setMonText.notifier).state = '';
    refProvider.read(setTueText.notifier).state = '';
    refProvider.read(setWedText.notifier).state = '';
    refProvider.read(setThuText.notifier).state = '';
    refProvider.read(setFriText.notifier).state = '';
    refProvider.read(setSatText.notifier).state = '';
    refProvider.read(setSunText.notifier).state = '';

    //
    refProvider.read(isBedTimeM.notifier).state = false;
    refProvider.read(isBedTimeT.notifier).state = false;
    refProvider.read(isBedTimeW.notifier).state = false;
    refProvider.read(isBedTimeThr.notifier).state = false;
    refProvider.read(isBedTimeF.notifier).state = false;
    refProvider.read(isBedTimeSat.notifier).state = false;
    refProvider.read(isBedTimeSun.notifier).state = false;

    //
    await pref.setInt(StorageBedTime.bedTimeKeyHr, 0);
    await pref.setInt(StorageBedTime.bedTimeKeyMin, 0);
    await pref.setString(StorageBedTime.bedTimeKeyPr, '');
    //
    await pref.setInt(StorageBedTime.wakeTimeKeyHr, 0);
    await pref.setInt(StorageBedTime.wakeTimeKeyMin, 0);
    await pref.setString(StorageBedTime.wakeTimeKeyPr, '');
    //
    await pref.setBool(StorageBedTime.isMSelectedKey, false);
    await pref.setBool(StorageBedTime.isTSelectedKey, false);
    await pref.setBool(StorageBedTime.isWSelectedKey, false);
    await pref.setBool(StorageBedTime.isThuSelectedKey, false);
    await pref.setBool(StorageBedTime.isFSelectedKey, false);
    await pref.setBool(StorageBedTime.isSatSelectedKey, false);
    await pref.setBool(StorageBedTime.isSunSelectedKey, false);
  }
}

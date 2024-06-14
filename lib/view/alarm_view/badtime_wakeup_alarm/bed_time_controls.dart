import '../alarm_export.dart';
import 'package:alarm_clock/view/alarm_view/badtime_wakeup_alarm/bed_time_storage.dart';
import 'package:alarm_clock/view/alarm_view/badtime_wakeup_alarm/bedtime_provider.dart';

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
  static isBedSetTrue() async {
    final pref = await StorageBedTime.objPreBedTime();
    await pref.setBool(StorageBedTime.showBedTimeKey, true);
  }

  static saveInfoBedTime() async {
    final pref = await StorageBedTime.objPreBedTime();
    if (refProvider.watch(isBedTimeM)) {
      await pref.setString(StorageBedTime.mKey, 'MON');
    }
    if (refProvider.watch(isBedTimeT)) {
      await pref.setString(StorageBedTime.tKey, 'TUE');
    }
    if (refProvider.watch(isBedTimeW)) {
      await pref.setString(StorageBedTime.wKey, 'WED');
    }
    if (refProvider.watch(isBedTimeThr)) {
      await pref.setString(StorageBedTime.thuKey, 'THU');
    }
    if (refProvider.watch(isBedTimeF)) {
      await pref.setString(StorageBedTime.thuKey, 'FRI');
    }
    if (refProvider.watch(isBedTimeSat)) {
      await pref.setString(StorageBedTime.thuKey, 'SAT');
    }
    if (refProvider.watch(isBedTimeSun)) {
      await pref.setString(StorageBedTime.thuKey, 'SUN');
    }
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
  }
}

import '../alarm_export.dart';

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

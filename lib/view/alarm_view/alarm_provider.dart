import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedHour = StateProvider((ref) => 0);
final selectedMin = StateProvider((ref) => 0);
final selectedPeriod = StateProvider((ref) => '');

final isM = StateProvider((ref) => false);
final isT = StateProvider((ref) => false);
final isW = StateProvider((ref) => false);
final isThr = StateProvider((ref) => false);
final isF = StateProvider((ref) => false);
final isSat = StateProvider((ref) => false);
final isSun = StateProvider((ref) => false);

 // if any of the day are picked when setting alarm
final isAnyDayPick = StateProvider((ref) => false);
final allDaysSelected = StateProvider((ref) => '');
final isCalenderDatePicked = StateProvider((ref) => false);
final dateSelectedOnCalender = StateProvider((ref) => '');

// if a particular day is selected
final monText = StateProvider((ref) => '');
final tueText = StateProvider((ref) => '');
final wedText = StateProvider((ref) => '');
final thrText = StateProvider((ref) => '');
final friText = StateProvider((ref) => '');
final satText = StateProvider((ref) => '');
final sunText = StateProvider((ref) => '');

// bedtime selected variables
final bedTimeSelectedHour = StateProvider((ref) => 0);
final bedTimeSelectedMin = StateProvider((ref) => 0);
final bedTimeSelectedPeriod = StateProvider((ref) => '');


// wakeUp time selected variables
final wakeTimeSelectedHour = StateProvider((ref) => 0);
final wakeTimeSelectedMin = StateProvider((ref) => 0);
final wakeTimeSelectedPeriod = StateProvider((ref) => '');

// sleeping period variables
final sleepingPeriodHour = StateProvider((ref) => 0);
final sleepingPeriodMin = StateProvider((ref) => 0);
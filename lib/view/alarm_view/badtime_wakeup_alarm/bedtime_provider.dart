import 'package:flutter_riverpod/flutter_riverpod.dart';

final isBedTimeM = StateProvider((ref) => false);
final isBedTimeT = StateProvider((ref) => false);
final isBedTimeW = StateProvider((ref) => false);
final isBedTimeThr = StateProvider((ref) => false);
final isBedTimeF = StateProvider((ref) => false);
final isBedTimeSat = StateProvider((ref) => false);
final isBedTimeSun = StateProvider((ref) => false);
final isBedSet = StateProvider((ref) => false);


final setMonText = StateProvider((ref) => '');
final setTueText = StateProvider((ref) => '');
final setWedText = StateProvider((ref) => '');
final setThuText = StateProvider((ref) => '');
final setFriText = StateProvider((ref) => '');
final setSatText = StateProvider((ref) => '');
final setSunText = StateProvider((ref) => '');

final displayBedTimeHr = StateProvider((ref) => 0);
final displayBedTimeMin = StateProvider((ref) => 0);
final displayBedTimePr = StateProvider((ref) => '');

final displayWakeTimeHr = StateProvider((ref) => 0);
final displayWakeTimeMin = StateProvider((ref) => 0);
final displayWakeTimePr = StateProvider((ref) => '');
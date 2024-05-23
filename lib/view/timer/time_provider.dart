import 'package:flutter_riverpod/flutter_riverpod.dart';

final isHourInputEmpty = StateProvider((ref) => false);
final isMinInputEmpty = StateProvider((ref) => false);
final isSecInputEmpty = StateProvider((ref) => false);
final isTimerSet = StateProvider((ref) => false);

final featureTime = StateProvider((ref) => '');
final featureTimePeriod = StateProvider((ref) => '');




final intHour = StateProvider((ref) => 00);
final intMin = StateProvider((ref) => 00);
final intSec = StateProvider((ref) => 00);

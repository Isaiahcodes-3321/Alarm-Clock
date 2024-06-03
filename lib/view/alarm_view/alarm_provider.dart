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

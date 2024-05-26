import 'package:flutter_riverpod/flutter_riverpod.dart';
// loopAudio: true,
//   vibrate: true,

final isLoopAudio = StateProvider((ref) => false);
final isVibrating = StateProvider((ref) => false);
final vibrateVolume = StateProvider((ref) => 0.5);
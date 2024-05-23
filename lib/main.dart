import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alarm_clock/view/nav_bar/nav_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:alarm_clock/view/timer/timer_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Alarm.init();
  final pref = await StorageTimer.objPre();
  await pref.setInt(StorageTimer.timerKeySec, 10);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return const ProviderScope(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeView(),
          ),
        );
      },
    );
  }
}

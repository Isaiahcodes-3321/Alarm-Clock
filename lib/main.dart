import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alarm_clock/background_running.dart';
import 'package:alarm_clock/view/nav_bar/nav_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Alarm.init();
  await SystemChrome.setPreferredOrientations([]);
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  // WidgetsBinding.instance.addPostFrameCallback((_) async {
  //   await requestPermissionForAndroid();
  //   initForegroundTask();
  // });
  // startForegroundTask();
  runApp(const MyApp());
}

@pragma('vm:entry-point')
startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return WithForegroundTask(
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return const ProviderScope(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeView(),
          ),
        );
      },
      // ),
    );
  }
}

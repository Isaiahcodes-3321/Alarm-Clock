import 'widgets/navigation.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alarm_clock/view/nav_bar/nav_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:awesome_notifications/awesome_notifications.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init app to run on background
  backgroundPermission();
  // end
  // init alarm
  await Alarm.init();
  await SystemChrome.setPreferredOrientations([]);
  //init notification
  AwesomeNotifications().initialize(
      // set the icon to null
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  runApp(const MyApp());
}

// background permission
backgroundPermission() async {
  // FlutterBackground.initialize();

  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "",
    notificationText:
        "App running in the background",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon: AndroidResource(
        name: 'background_icon',
        defType: 'drawable'), 
  );
  await FlutterBackground.initialize(androidConfig: androidConfig);

  await FlutterBackground.hasPermissions;
  await FlutterBackground.enableBackgroundExecution();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return ProviderScope(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigateKey,
            home: const HomeView(),
          ),
        );
      },
    );
  }
}

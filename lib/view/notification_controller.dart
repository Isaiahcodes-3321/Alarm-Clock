import 'package:alarm/alarm.dart';
import 'timer/time_controller.dart';
import 'package:alarm_clock/view/nav_bar/nav_provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:alarm_clock/view/global_controls/global_provider.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
    await Alarm.set(alarmSettings: alarmSettings);
    print('show notification');
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    refProvider.read(isNotificationClick.notifier).state = true;
    await Alarm.stop(alarmId);

    //  refProvider.read(isNotificationClick.notifier).state = true;

    print('User clicks on the body');
    // // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
    //         (route) => (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);
  }
}

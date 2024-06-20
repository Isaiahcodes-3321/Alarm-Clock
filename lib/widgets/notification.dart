import 'package:awesome_notifications/awesome_notifications.dart';

// Widget to show notification
showNotificationCountDown() => AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      actionType: ActionType.Default,
      title: 'Hello Dear User',
      body: 'Your time its up Click notification to stop alarm',
    ));

showNotificationAlarm() => AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      actionType: ActionType.Default,
      title: 'Hello Dear User',
      body: 'Your alarm time its up',
    ));

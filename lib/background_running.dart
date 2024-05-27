import 'dart:io';
import 'dart:isolate';
import 'package:alarm/alarm.dart';
import 'package:alarm_clock/main.dart';
import 'package:alarm_clock/view/timer/countDown_view.dart';
import 'package:alarm_clock/view/timer/time_controller.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

initForegroundTask() {
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      foregroundServiceType: AndroidForegroundServiceType.DATA_SYNC,
      channelId: 'foreground_service',
      channelName: 'Foreground Service Notification',
      channelDescription: 'This notification appears when the foreground service is running.',
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.LOW,
      iconData: const NotificationIconData(
        resType: ResourceType.mipmap,
        resPrefix: ResourcePrefix.ic,
        name: 'launcher',
      ),
      buttons: [
        const NotificationButton(id: 'sendButton', text: 'Send'),
        const NotificationButton(id: 'testButton', text: 'Test'),
      ],
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: true,
      playSound: false,
    ),
    foregroundTaskOptions: const ForegroundTaskOptions(
      interval: 5000,
      isOnceEvent: false,
      autoRunOnBoot: true,
      allowWakeLock: true,
      allowWifiLock: true,
    ),
  );
}

class MyTaskHandler extends TaskHandler {
  SendPort? _sendPort;
  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) {
    // TODO: implement onDestroy
  }

  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) {
    // TODO: implement onRepeatEvent
  }

  @override
  void onStart(DateTime timestamp, SendPort? sendPort) {
    // TODO: implement onStart
    widgetTimer();
  }

  @override
  void onNotificationPressed() {
    _sendPort?.send('onNotificationPressed');
    // Call the stop alarm function here
    stopAlarm();
  }

  void stopAlarm() async {
    await Alarm.stop(alarmId);
  }
}

ReceivePort? _receivePort;
Future<void> requestPermissionForAndroid() async {
  if (!Platform.isAndroid) {
    return;
  }
}

bool registerReceivePort(ReceivePort? newReceivePort) {
  if (newReceivePort == null) {
    return false;
  }

  _closeReceivePort();

  _receivePort = newReceivePort;
  return _receivePort != null;
}

_closeReceivePort() {
  _receivePort?.close();
  _receivePort = null;
}

Future<bool> startForegroundTask() async {
  // You can save data using the saveData function.
  await FlutterForegroundTask.saveData(key: 'customData', value: 'hello');

  // Register the receivePort before starting the service.
  final ReceivePort? receivePort = FlutterForegroundTask.receivePort;
  final bool isRegistered = registerReceivePort(receivePort);
  if (!isRegistered) {
    print('Failed to register receivePort!');
    return false;
  }

  if (await FlutterForegroundTask.isRunningService) {
    return FlutterForegroundTask.restartService();
  } else {
    return FlutterForegroundTask.startService(
      notificationTitle: 'Foreground Service is running',
      notificationText: 'Tap to return to the app',
      callback: startCallback(),
    );
  }
}

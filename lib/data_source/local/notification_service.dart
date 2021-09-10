import 'package:flutter_getx/routes/app_routes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notify_icon');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );
  }

  Future selectNotification(String? payload) async {
    Get.toNamed(
      AppRoute.detailPost,
      arguments: 1,
    );
  }

  void showNotification() async {
    int id = 100;
    String applicationName = 'Flutter GetX';
    String detailMessages = 'This is body';
    String payload = '1001';

    await flutterLocalNotificationsPlugin.show(
        id,
        applicationName,
        detailMessages,
        NotificationDetails(
          android:
              AndroidNotificationDetails('1', applicationName, detailMessages),
        ),
        payload: '1');
  }

  Future<void> zonedSchedule() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      123,
      'Flutter GetX Schedule',
      'This is Schedule',
      TZDateTime.now(local).add(
        const Duration(seconds: 10),
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            '2', 'Schedule Noti', 'Schedule Notification Des'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(123);
  }
}

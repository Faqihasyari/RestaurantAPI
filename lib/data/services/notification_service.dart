import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initSettings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings: initSettings);

    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }
  // kode debug
  // static Future<void> showTest() async {
  //   await _notifications.show(
  //     id: 999,
  //     title: 'Test Notification',
  //     body: 'Kalau ini muncul berarti service aman',
  //     notificationDetails: const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'test',
  //         'Test',
  //         importance: Importance.max,
  //         priority: Priority.high,
  //       ),
  //     ),
  //   );
  // }

  static Future<void> scheduleDailyReminder() async {
    final scheduledTime = _nextInstanceOfElevenAM();

    print('Scheduled at: $scheduledTime');

    await _notifications.zonedSchedule(
      id: 0,
      title: 'Waktunya Makan Siang 🍽️',
      body: 'Yuk cek restoran favoritmu sekarang!',
      scheduledDate: scheduledTime,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder',
          'Daily Reminder',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> cancelReminder() async {
    await _notifications.cancel(id: 0);
  }

  static tz.TZDateTime _nextInstanceOfElevenAM() {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }
}

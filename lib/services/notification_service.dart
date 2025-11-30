import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // 1. Initialize Timezones
    tz.initializeTimeZones();

    // TEMPORARY FIX: Hardcode the timezone to your local one for now.
    // Since the timezone plugin is broken, this ensures the app builds.
    // Later, you can replace 'America/New_York' with your specific region,
    // or use DateTime.now().timeZoneName (though that can be flaky).
    const String timeZoneName = "America/New_York";

    try {
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      // If the location fails, default to UTC to prevent crashing
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
  }

  Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledTime) async {
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'task_channel_id',
            'Task Reminders',
            channelDescription: 'Channel for task reminder notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        // REQUIRED PARAMETER YOU MISSED:
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}

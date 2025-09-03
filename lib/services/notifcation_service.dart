// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notifications =
//       FlutterLocalNotificationsPlugin();

//   /// 🔹 Initialize notifications (call this in main.dart)
//   static Future<void> init() async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: android);

//     await _notifications.initialize(settings);
//   }

//   /// 🔹 Show simple notification
//   static Future<void> showNotification({
//     required String title,
//     required String body,
//   }) async {
//     const androidDetails = AndroidNotificationDetails(
//       'job_channel', // channel id
//       'Job Notifications', // channel name
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     const details = NotificationDetails(android: androidDetails);

//     await _notifications.show(
//       0, // notification id
//       title,
//       body,
//       details,
//     );
//   }

//   /// 🔹 Schedule notification (e.g., reminder after 5 seconds)
//   static Future<void> scheduleNotification({
//     required String title,
//     required String body,
//     required Duration delay,
//   }) async {
//     const androidDetails = AndroidNotificationDetails(
//       'job_channel',
//       'Job Notifications',
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     const details = NotificationDetails(android: androidDetails);

//     await _notifications.zonedSchedule(
//       0,
//       title,
//       body,
//       // DateTime.now().add(delay),
//       details,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
// }

//
//
// // Flutter imports:
// import 'package:firebase_messaging/firebase_messaging.dart';
// // Package imports:
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// // Project imports:
//
//
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   static void initialize() {
//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: DarwinInitializationSettings()
//     );
//     _notificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: (payload)async{
//       if (payload.payload != null) {
//         // Open the PDF file
//         if (await canLaunch(payload.payload!)) {
//       await launch(payload.payload!);
//       } else {
//       throw 'Could not launch $payload';
//       }
//       }
//
//     });
//   }
//
//
//
//   static void normaldisplay(int id,String title,String body,RemoteMessage message,context) async {
//     try {
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//       NotificationDetails notificationDetails = const NotificationDetails(
//           android: AndroidNotificationDetails(
//             "Green Ride",
//             "greenRide",
//             icon: '@mipmap/ic_launcher',
//             importance: Importance.max,
//             priority: Priority.high,
//             playSound: true,
//           ),
//           iOS: DarwinNotificationDetails()
//       );
//
//       await _notificationsPlugin.show(
//         id,
//         title,
//         body,
//         notificationDetails,
//       );
//       const InitializationSettings initializationSettings =
//       InitializationSettings(
//           android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//           iOS: DarwinInitializationSettings()
//       );
//       _notificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: (payload)async{
//         if(payload.payload != null)
//           {
//           }
//
//
//       });
//     } on Exception catch (e) {
//
//     }
//   }
// }
//
//
//
//
//
//
//
//

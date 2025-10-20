import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseCloudMessaging{
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future<void> requestPremission() async {
  NotificationSettings  settings= await messaging.requestPermission(
  alert: true,
  announcement: false,
  badge: true,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    }
  static Future<String?> getToken() async {
    String? token = await messaging.getToken();
    print(token);
    return token;

  }
  static Future<void> init() async {
    requestPremission();
    getToken();
    subscribeTopic("sports");
    onForgroundFcm();
    onBackgroundFcm();
  }
  static Future<void> subscribeTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
    print("you have been subscribe to $topic");

  }
  static Future<void> unSubscribeTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    print("you have been unSubscribe to $topic");

  }
  static Future<void> onForgroundFcm() async {
    final AndroidNotificationChannel channel =await const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:  'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
               channelDescription:  channel.description,
                icon: "@mipmap/ic_launcher",
                importance: Importance.max,
                // other properties...
              ),
            ));
      }
    });
  }
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  } 
    static Future<void> onBackgroundFcm() async {
 FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
  

  }
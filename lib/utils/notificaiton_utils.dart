import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class NotificationUtils {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static late BuildContext _context;

  /// Create a [AndroidNotificationChannel] for heads up notifications
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    await Firebase.initializeApp();
    log("onBackgroundMessage: $message");

    return Future<void>.value();
  }

  static Future<void> init(BuildContext context) async {
    var token = await _firebaseMessaging.getAPNSToken();

    log("---------------------------");
    log("Token -> $token");
    log("Notification setting");
    log("================");
    log("---------------------------");

    _context = context;

    try {
      log("notification permission started");

      await _firebaseMessaging.requestPermission();
    } catch (e) {
      log("notification permission$e");
    }
    await initLocalNotifications();
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: false, badge: false, sound: false);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message1) {});
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification notification = message!.notification!;
      /*if (notification.title.contains("Agent")) {
        deBouncer.run(() {
          getAgentData(AssistantScreenController.user.email);
        });
      }
*/
      localNotification(notification.title ?? "", notification.body ?? "", "");
    });
  }

  //**************************************************
  static Future onSelectNotification(String? payload) async {
    /*List<String> data = [];
    data = payload?.split('+');
    log("clicked" + payload);
    if (payload.toString().contains("sent you")) {
      // Navigator.pushNamed(_context, ChatScreen.id);
    }
    */
  }

  //**************************************************
  static Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  //**************************************************
  static Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    showDialog(
      context: _context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title ?? ""),
        content: Text(body ?? ""),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      ),
    );
  }

  //**************************************************
  static Future<void> localNotification(
      String title, String body, String payload) async {
    log("in local notification function $title $body");
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '1',
      title,
      importance: Importance.max,
      priority: Priority.low,
      showWhen: false,
      styleInformation: const BigTextStyleInformation(''),
    );
    IOSNotificationDetails iosPlatformChannelSpecifics =
        const IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);
    log("starting");
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload
            //payload: '$senderId + $notificationType',
            );
    log("completed");
  }

  static Future<void> fcmSubscribe() async {
    try {
      var token = await _firebaseMessaging.getToken();
      log("fcm token$token");
    } catch (e) {
      log("fcm token$e");
    }

    var topic = FirebaseAuth.instance.currentUser?.uid ?? "sa";
    log("subscribed $topic");
    await _firebaseMessaging.subscribeToTopic(topic).then((value) {
      log("subscribed");
    });
  }

  static Future<void> fcmUnSubscribe() async {
    await _firebaseMessaging
        .unsubscribeFromTopic(FirebaseAuth.instance.currentUser?.uid ?? "sa");
  }

  static Debouncer deBouncer =
      Debouncer(delay: const Duration(milliseconds: 1000));
}

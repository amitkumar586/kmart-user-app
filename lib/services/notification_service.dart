import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:kmart/const/consts.dart';
import 'package:kmart/views/home_screen/home_screen.dart';

class NotoficationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // for request notification
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted provisional permission');
    } else {
      Get.snackbar("Netification Permissions denied",
          "Please allow notifications ro receive updates",
          snackPosition: SnackPosition.BOTTOM);

      Future.delayed(const Duration(seconds: 2), () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
    }
  }

  Future<String> getDeviceToken() async {
    // ignore: unused_local_variable
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    String? deviceToken = await messaging.getToken();
    print("token yaha hai ==> $deviceToken");
    return deviceToken!;
  }

  // init
  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitSetting =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitSetting = DarwinInitializationSettings();

    var initilizationSetting = InitializationSettings(
      android: androidInitSetting,
      iOS: iosInitSetting,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initilizationSetting,
      onDidReceiveNotificationResponse: (payload) {
        handlleMessage(context, message);
      },
    );
  }

  // firebase init

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen(
      (message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification!.android;

        if (kDebugMode) {
          print("notification title :   ${notification!.title}");
          print("notification body :   ${notification.body}");
        }

        // checking fot ios messase

        if (Platform.isIOS) {
          iosForgroundMessage();
        }

        // checking fot android messase

        if (Platform.isAndroid) {
          initLocalNotification(context, message);
          // handlleMessage(context, message);
          showNotification(message);
        }
      },
    );
  }

  // funtion to show notifications

  Future<void> showNotification(RemoteMessage message) async {
    //channe; setting
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString(),
        importance: Importance.high,
        playSound: true,
        showBadge: true);

    // android setting

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'channelDescription',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      sound: channel.sound,
    );

    // ios setting

    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    // merge notification

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    // show notification
    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
          payload: "my_data");
    });
  }

  // background and terminate
  Future<void> setupIntractMessage(BuildContext context) async {
    //background state

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handlleMessage(context, event);
    });

    // terminate state

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (messaging != null && message!.data.isNotEmpty) {
        handlleMessage(context, message);
      }
    });
  }

  // message handler
  Future<void> handlleMessage(
      BuildContext context, RemoteMessage message) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  // ios message
  Future iosForgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

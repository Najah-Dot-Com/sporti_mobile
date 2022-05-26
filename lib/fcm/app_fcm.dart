// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sporti/feature/model/exercises_package_data.dart';
import 'package:sporti/feature/viewmodel/details_exercise_view_model.dart';
import 'package:sporti/feature/viewmodel/home_viewmodel.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/constance.dart';
import 'package:sporti/util/sh_util.dart';
import '../feature/view/views/categoriy_exercise_details/categoriy_exercise_details_view.dart';
import '../feature/viewmodel/notification_viewmodel.dart';

class AppFcm {
  AppFcm._();

  static final AppFcm fcmInstance = AppFcm._();

  factory AppFcm() => fcmInstance;

  init() {
    configuration();
    registerNotification();
    getTokenFCM();
  }

  ValueNotifier<int> notificationCounterValueNotifer = ValueNotifier(0);
  ValueNotifier<bool> isChatPageOpen = ValueNotifier(false);
  ValueNotifier<String> userChatId = ValueNotifier("");
  MethodChannel platform =
      const MethodChannel('dexterx.dev/flutter_local_notifications_example');

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  RemoteMessage messages = RemoteMessage();
  static final DetailsExerciseViewModel _detailsExerciseViewModel =
      Get.put<DetailsExerciseViewModel>(DetailsExerciseViewModel());
  static final HomeViewModel _homeViewModel =
      Get.put<HomeViewModel>(HomeViewModel());
  static final NotificationViewModel _notificationsViewModel =
      Get.put<NotificationViewModel>(NotificationViewModel());

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'com.naja7.sporti', // id
    'com.naja7.sporti', // title
    //'IMPORTANCE_HIGH', // description
    importance: Importance.max,
    //showBadge: true,
  );

  void updatePages(RemoteMessage message) async {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Get.put<HomeViewModel>(HomeViewModel()).allPackagesExercises();
      Get.put<HomeViewModel>(HomeViewModel()).allPackagesTopExercises();
      Get.put<NotificationViewModel>(NotificationViewModel()).notificatiosDataList.clear();
      Get.put<NotificationViewModel>(NotificationViewModel()).getAllNotifications(1);
    });
    Future.delayed(Duration(seconds: 3)).then((value) {
      //flutterLocalNotificationsPlugin.cancelAll();
    });
  }

  configuration() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('drawable/icons_app');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    final notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      await selectNotification(notificationAppLaunchDetails?.payload);
    }
  }

  Future selectNotification(String? payload) async {
    try {
      // RemoteMessage message = messages;
      goToOrderPage(messages.data);
    } catch (e) {
      print(e);
      Logger().d(e);
    }
  }

  void registerNotification() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      //todo this for add badge for app
      Logger().e(
          "android_ ${message.data}  ${message.notification?.android.toString().toString()}");
      var android = message.data;
      messages = message;
      Logger().e("android $android  \n ios ${notification.title}");
      //todo this for update ui when recive message
      updatePages(message);
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            iOS: IOSNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              /* subtitle: message.notification.body,*/
            ),
            android: AndroidNotificationDetails(
                channel.id, channel.name, //channel.description,
                enableLights: true,
                enableVibration: true,
                fullScreenIntent: true,
                autoCancel: true,
                importance: Importance.max,
                priority: Priority.high,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                color: const Color(0xFF26C3AE)),
          ),
          payload: "${message.data}");
    });
  }

  getTokenFCM() async {
    await _firebaseMessaging.getToken().then((token) {
      Logger().i("fcmToken:$token");
      SharedPref.instance.setFCMToken(token.toString());
    }).catchError((err) {
      Logger().d(err);
    });
  }

  static void goToOrderPage(Map<String, dynamic> map,
      {bool? isFromTerminate}) async {
    var packageDetails = ExercisesData(
      id: map["id"],
    );
    try {
      if (map[ConstanceNetwork.notifyType] == Constance.newExersiceType) {
        Get.to(() => CategoriyExerciseDetailsView(packageDetails: packageDetails));
      } else if (map[ConstanceNetwork.notifyType] ==
          Constance.returnExersiceType) {
        Get.to( () => CategoriyExerciseDetailsView(packageDetails: packageDetails));
      } else {
        // _homeViewModel.onTabChange(0);
      }
    } on Exception catch (e) {
      Logger().i('goToOrderPage Error', e.toString());
    }
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      Logger().d("remote message $initialMessage");
      _handleMessage(initialMessage);
    }
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print("MSG_BUG _handleMessage");
    AppFcm.goToOrderPage(message.data, isFromTerminate: true);
  }
}

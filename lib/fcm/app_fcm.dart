// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//class of app notifications
class AppFcm {
  AppFcm._();
  static final AppFcm fcmInstance = AppFcm._();
  factory AppFcm() => fcmInstance;
  static String myToken ="";
  // late MyPerson? person;
  init() {
    configuration();
    // registerNotification();
    // getTokenFCM();
    
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

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'com.naja7.sporti.sporti', // id
    'com.naja7.sporti.sporti', // title
    //'IMPORTANCE_HIGH', // description
    importance: Importance.max,
    //showBadge: true,
  );

  // void updatePages(RemoteMessage message) async {
  //   WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
  //     Get.put(UserController()).getPeopleHeLikeMeNotification();
  //   });
  //   Future.delayed(Duration(seconds: 3)).then((value) {
  //     //flutterLocalNotificationsPlugin.cancelAll();
  //   });
  // }

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

    // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: selectNotification);
    final notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    //   await selectNotification(notificationAppLaunchDetails?.payload);
    }
  }

  // Future selectNotification(String? payload) async {
  //   try {
  //     // RemoteMessage message = messages;
  //     goToOrderPage(messages.data);
  //     Get.to(Home(
  //       selectedIndex: 2,
  //     ));
      
  //   } catch (e) {
  //     print(e);
  //     Logger().d(e);
  //   }
  

  // void registerNotification() async {
    // NotificationSettings settings = await _firebaseMessaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );

    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    // await FirebaseMessaging.instance
    //     .setForegroundNotificationPresentationOptions(
    //   alert: false,
    //   badge: true,
    //   sound: true,
    // );
  
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification notification = message.notification!;
    //   //todo this for add badge for app
    //   Logger().e(
    //       "android_ ${message.data}  ${message.notification?.android.toString().toString()}");
    //   var android = message.data;

      // if (isChatPageOpen.value && message.data["id"] == userChatId.value) {
      // } else {
      //   messages = message;
      //   Logger().e("android $android  \n ios ${notification.title}");
      //   //todo this for update ui when recive message
      //   updatePages(message);
      //   flutterLocalNotificationsPlugin.show(
      //       notification.hashCode,
      //       notification.title,
      //       notification.body,
      //       NotificationDetails(
      //         iOS: IOSNotificationDetails(
      //           presentAlert: true,
      //           presentBadge: true,
      //           presentSound: true,
      //           /* subtitle: message.notification.body,*/
      //         ),
      //         android: AndroidNotificationDetails(
      //             channel.id, channel.name, //channel.description,
      //             enableLights: true,
      //             enableVibration: true,
      //             fullScreenIntent: true,
      //             autoCancel: true,
      //             importance: Importance.max,
      //             priority: Priority.high,
      //             // TODO add a proper drawable resource to android, for now using
      //             //      one that already exists in example app.
      //             color: const Color(0xFF3A1C1A)),
      //       ),
      //       payload: "${message.data}");
      // }
    // });
  // }

  // getTokenFCM() async {
  //   await _firebaseMessaging.getToken().then((token) {
  //     // Logger().d('token fcm : $token');
  //     // person!.token = token;
  //     myToken = token.toString();
  //    var auth =  FirebaseAuth.instance;
  //     if(auth.currentUser != null && auth.currentUser?.uid != null && AthService.userService.getUserIdFromLocalStorage().isNotEmpty) {
  //       updateUserPerson(token!);
  //       updateUser(token);
  //     }
  //     ///todo SharedPref.instance.setFCMToken(token.toString());
  //   }).catchError((err) {
  //     Logger().d(err);
  //   });
  // }

  // static void goToOrderPage(Map<String, dynamic> map) {
  //   Get.to(const ChatHomeScreen());
  //   MyPerson person = MyPerson(
  //       id: map["id"],
  //       imagePath: map["imagePath"],
  //       name: map["name"],
  //       token: map["token"]);
  //   if (map["type"] != null && map["type"] == "chat") {
  //     Get.to(ChatScreen(
  //       person: person,
  //     ));
  //   }
  // }

  // Future updateUserPerson(String token) async {
    // try {
    //   await FirebaseFirestore.instance
    //           .collection("userStatues")
    //           .doc("${FirebaseAuth.instance.currentUser?.uid.toString()}/peopleIamLiked")
    //           .update({"token": "$token"}).then((value) {
    //         Logger().i("Success update Token");
    //       }).catchError((onError) {
    //         Logger().e("$onError");
    //       });
    // } catch (e) {
    //   print(e);
    // }
  // }

  // Future updateUser(String token) async {
  //   try {
  //     if(FirebaseAuth.instance.currentUser != null) {
  //        FirebaseFirestore.instance
  //           .collection("users")
  //           .doc("${FirebaseAuth.instance.currentUser?.uid.toString()}")
  //           .update({"token": "$token"}).then((value) {
  //         Logger().i("Success update Token");
  //       }).catchError((onError) {
  //         Logger().e("$onError");
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  //subscribe
  // fcmSubscribe()async{
  //   if(FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser?.uid != null){
  //     final UserController _userController = Get.put(UserController());
  //       if(_userController.myUser.value.gendervalue == "رجل") {
  //          _firebaseMessaging.subscribeToTopic('man');
  //       }else{
  //          _firebaseMessaging.subscribeToTopic('woman');
  //       }
  //   }
  // }


import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/view/views/auth_login/auth_login_view.dart';
import 'package:sporti/feature/view/views/auth_on_bording/on_bording_view.dart';
import 'package:sporti/feature/view/views/home_page/home_page_view.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/connectivity_widget.dart';
import 'package:sporti/util/sh_util.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  var isOffline = false;
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initListener();
      if (!isOffline) {
        Timer(const Duration(seconds: 3), () {
        // Logger().i(
        //     "${SharedPref.instance.getIsUserLogin()},${SharedPref.instance.getIsUserLogin() is String}");
        if (SharedPref.instance.getIsUserLogin()) {
          Get.offAll(const HomePageView());
        } else {
          if (SharedPref.instance.getOnBoardingView()) {
            Get.offAll(LoginView());
          } else {
            Get.offAll(const OnBoardingView());
          }
        }
      });
      }
    });
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation =
        CurvedAnimation(parent: animationController!, curve: Curves.easeOut);

    animation?.addListener(() => setState(() {}));
    animationController?.forward();

    setState(() {
      _visible = !_visible;
    });
  }

  // app logo widget
  Widget get splashLogo => Center(
        child: Image(
          image: const AssetImage(AppMedia.sportiGreenLogo),
          width: animation!.value * AppSize.s300,
          height: animation!.value * AppSize.s300,
        ),
      );

  void initListener() async {
    var result = await checkInternetConnectivity();
    if (!result) {
      isOffline = true;
      setState(() {});
    }
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
      scaffold: Scaffold(
        backgroundColor: Colors.white,
        body: splashLogo,
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/views/auth_login/auth_login_view.dart';
import 'package:sporti/util/app_media.dart';
class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // app logo widget
  Widget get splashLogo => const Center(
    child: Image(
      image: AssetImage(AppMedia.sportiGreenLogo),
    ),
  );

  @override
  initState(){
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Timer(const Duration(seconds: 3), () => {Get.offAll(const LoginView())});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: splashLogo,
    );
  }
}

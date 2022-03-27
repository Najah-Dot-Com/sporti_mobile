import 'package:flutter/material.dart';
import 'package:sporti/util/app_media.dart';
class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);
  
  // app logo widget 
  Widget get splashLogo => const Center(
    child: Image(
      image: AssetImage(AppMedia.sportiGreenLogo),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: splashLogo,
    );
  }
}

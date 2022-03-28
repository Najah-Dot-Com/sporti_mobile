import 'package:flutter/material.dart';
import 'package:sporti/util/app_color.dart';

import '../../../util/app_media.dart';

// ignore: must_be_immutable
class AppLogo extends StatelessWidget {
  double? width = 50;
  double? height = 50;
  Color? logoColor = AppColor.white;
  AppLogo({Key? key, @required this.height, @required this.width,@required this.logoColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SizedBox(
        width: width,
        height: height,
        child: 
        logoColor == AppColor.white?
        const Image(
          image: AssetImage(AppMedia.sportiWhiteLogo),
        ):const Image(
          image: AssetImage(AppMedia.sportiGreenLogo),
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';

class ShimmerSelectYourWorkWidget extends StatelessWidget {
  const ShimmerSelectYourWorkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSize.s18),
      height: AppSize.s85,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Image.asset(
        AppMedia.loadingShimmer,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

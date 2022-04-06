import 'package:flutter/material.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';

class ShimmerNewlyItemWidget extends StatelessWidget {
  const ShimmerNewlyItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Container(
      margin:const EdgeInsets.symmetric(horizontal: AppSize.s6),
      width: AppSize.s150,
      height: AppSize.s120,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s30)
      ),
      child:Image.asset(AppMedia.loadingShimmer ,width: double.infinity,fit: BoxFit.cover,),
    );
  }

}

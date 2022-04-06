import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/categoriy_exercise_details/categoriy_exercise_details_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/constance.dart';

class ShimmerCategoriesListItemWidget extends StatelessWidget {
  const ShimmerCategoriesListItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      height: AppSize.s85,
      margin:  const EdgeInsets.only(bottom: AppSize.s10 ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child:Image.asset(AppMedia.loadingShimmer ,width: double.infinity,fit: BoxFit.cover,),
    );
  }


}

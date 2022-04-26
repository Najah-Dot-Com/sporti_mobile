import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/exercises_package_data.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/categoriy_exercise_details/categoriy_exercise_details_view.dart';
import 'package:sporti/feature/viewmodel/home_viewmodel.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/constance.dart';
import 'package:sporti/util/date_time_util.dart';

class CategoriesListItemWidget extends StatelessWidget {
  const CategoriesListItemWidget({
    Key? key,
    required this.packageDetails,required this.viewModel,
  }) : super(key: key);
  final ExercisesData? packageDetails;
  final  HomeViewModel? viewModel;
  final String fakeImage =
      "https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/07/1377301-1183869-The-8-Best-Weight-Benches-of-2021-1296x728-Header-c0dcdf.jpg?w=1575";

  @override
  Widget build(BuildContext context) {
    Logger().e(packageDetails?.toJson());
    var themeData = Theme.of(context);
    return InkWell(
      onTap: _onExerciseClick,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: AppSize.s10),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSize.s12, vertical: AppSize.s10),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSize.s6),
              width: AppSize.s76,
              height: AppSize.s76,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s12)),
              child: imageNetwork(
                  width: AppSize.s150,
                  height: AppSize.s120,
                  fit: BoxFit.cover,
                  url:"${ConstanceNetwork.baseImageExercises}${packageDetails?.imageSingleSlide??fakeImage}" ),
            ),
            const SizedBox(
              width: AppSize.s20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextView(
                    txt: packageDetails?.title.toString(),
                    maxLine: Constance.maxLineOne,
                    textOverflow: TextOverflow.ellipsis,
                    textStyle: themeData.textTheme.headline2?.copyWith(
                        color: AppColor.black, fontSize: AppFontSize.s16),
                  ),
                  const SizedBox(
                    height: AppSize.s6,
                  ),
                  CustomTextView(
                    txt: packageDetails!.isRetuen!
                        ? _returnInData()
                        : packageDetails!.isDone!
                            ? AppStrings.txtDone.tr
                            : AppStrings.txtNotPlayed.tr,
                    maxLine: Constance.maxLineOne,
                    textOverflow: TextOverflow.ellipsis,
                    textStyle: themeData.textTheme.subtitle2
                        ?.copyWith(color: AppColor.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: AppSize.s20,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColor.grey,
            ),
          ],
        ),
      ),
    );
  }

  void _onExerciseClick() async{
   var result =  await Get.to(CategoriyExerciseDetailsView(packageDetails: packageDetails));
   if(result){
      viewModel?.packagesExercisesDetails(packageDetails?.parentId);
   }
  }

  String _returnInData() {
    return AppStrings.txtReturnIn.tr +
        " " +
        DateUtility.convertDateTimeToAmPmTime(DateUtility.convertTimeTo24(
                    DateUtility.stringToTimeOfDay(
                        packageDetails!.returnTime.toString()))).toString();
  }
}

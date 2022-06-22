import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sporti/feature/model/exercises_package_data.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/categoriy_exercise/categoriy_exercise_view.dart';
import 'package:sporti/feature/view/views/categoriy_exercise_details/widget/page_shimmer_widget.dart';
import 'package:sporti/feature/viewmodel/details_exercise_view_model.dart';
import 'package:sporti/feature/viewmodel/home_viewmodel.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';
import 'package:sporti/util/app_style.dart';

class CategoriyExerciseDetailsView extends StatelessWidget {
  const CategoriyExerciseDetailsView({Key? key, required this.packageDetails,})
      : super(key: key);

  final ExercisesData? packageDetails;
  final String fakeImage = "https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/07/1377301-1183869-The-8-Best-Weight-Benches-of-2021-1296x728-Header-c0dcdf.jpg?w=1575";

  DetailsExerciseViewModel get detailsViewModel =>
      Get.put(DetailsExerciseViewModel());

  PreferredSizeWidget myAppBar(ThemeData themeData) =>
      AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: CustomTextView(
          txt: packageDetails?.title,
          textStyle: themeData.textTheme.headline2?.copyWith(
              color: AppColor.black),
        ),
        leading: IconButton(
          onPressed: () => Get.back(result: true),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.black,
          ),
        ),
      );


  Widget myStartBtn(ThemeData themeData, DetailsExerciseViewModel logic) =>
      InkWell(onTap:()=> _onStartBtnClick(logic), child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSize.s28, vertical: AppSize.s12),
        decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [AppShadow.boxShadow()!],
            borderRadius: BorderRadius.circular(AppSize.s28)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppMedia.play),
            const SizedBox(width: AppSize.s10,),
            CustomTextView(
              txt: AppStrings.txtPlay.tr,
              textStyle: themeData.textTheme.headline2?.copyWith(
                  color: AppColor.black),
            ),
          ],
        ),
      ),
      );


  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return WillPopScope(
      onWillPop: (){
        Get.back(result: true);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: myAppBar(themeData),
        floatingActionButton: GetBuilder<DetailsExerciseViewModel>(builder: (logic) {
          return  logic.isLoading ? const SizedBox.shrink():  myStartBtn(themeData , logic);
        }),
        backgroundColor: AppColor.white,
        body: GetBuilder<DetailsExerciseViewModel>(
          init: DetailsExerciseViewModel(),
          initState: (state) {
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              state.controller?.getExerciseDetails(packageDetails?.id);
            });
          },
          builder: (logic) {
            if (logic.isLoading) {
              return const PageShimmerWidget();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s28),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSize.s28,),
                  ClipRRect(borderRadius: BorderRadius.circular(AppSize.s12),
                      child: imageNetwork(width: double.infinity,
                          height: AppSize.s400,
                          fit: BoxFit.cover,
                          url:logic.exerciseDetailsData?.image == null ? fakeImage: "${ConstanceNetwork.baseImageExercises}${logic.exerciseDetailsData?.image}")),
                  const SizedBox(height: AppSize.s28,),
                  CustomTextView(
                    txt: logic.exerciseDetailsData?.title,
                    textStyle: themeData.textTheme.headline2?.copyWith(
                        color: AppColor.black),
                  ),
                  const SizedBox(height: AppSize.s12,),
                  CustomTextView(
                    txt: logic.exerciseDetailsData?.description,
                    textStyle: themeData.textTheme.subtitle2?.copyWith(
                        color: AppColor.darkGrey, height: AppSize.s1_5),
                  ),
                  const SizedBox(height: AppSize.s28,),
                  if(logic.exerciseDetailsData?.targetMusales != null)...[
                    CustomTextView(
                      txt: AppStrings.txtTargetMuscle.tr,
                      textStyle: themeData.textTheme.headline2?.copyWith(
                          color: AppColor.black),
                    ),
                    const SizedBox(height: AppSize.s12,),
                    CustomTextView(
                      txt: logic.exerciseDetailsData?.targetMusales ,
                      textStyle: themeData.textTheme.subtitle2?.copyWith(
                          color: AppColor.darkGrey, height: AppSize.s1_5),
                    ),
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  void _onStartBtnClick(DetailsExerciseViewModel logic) async{
    await showIsVerifyDialog(isNeedSubscriptions: true).then((value) async{
      if(value){
        Get.to(CategoryExerciseView(exerciseDetailsData:logic.exerciseDetailsData,packageDetails:packageDetails));
      }
    });
  }
}

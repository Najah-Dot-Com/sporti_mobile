import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/exercise_details_data.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/dialog/gloable_dialog_widget.dart';
import 'package:sporti/feature/view/appwidget/viedo_player.dart';
import 'package:sporti/feature/viewmodel/details_exercise_view_model.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_shaerd_data.dart';

import '../../../../util/app_color.dart';
import '../../../../util/app_dimen.dart';
import '../../../../util/app_strings.dart';

// ignore: must_be_immutable
class CategoryExerciseView extends StatefulWidget {
  const CategoryExerciseView({
    Key? key,
    required this.exerciseDetailsData,
  }) : super(key: key);

  final ExerciseDetailsData? exerciseDetailsData;

  @override
  State<CategoryExerciseView> createState() => _CategoryExerciseViewState();
}

class _CategoryExerciseViewState extends State<CategoryExerciseView> {
  final DetailsExerciseViewModel _detailsExerciseViewModel =
      Get.put(DetailsExerciseViewModel());

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _detailsExerciseViewModel.startTimer(widget.exerciseDetailsData);
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return WillPopScope(
      onWillPop: () {
        if (!_detailsExerciseViewModel.isStartVideo &&
            _detailsExerciseViewModel.isEndVideo) {
          return Future.value(true);
        } else {
          showCustomDialog();
        }
        Logger().d(_detailsExerciseViewModel.timeExercise);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColor.lightBlue,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: AppColor.white,
          title: CustomTextView(
            txt: widget.exerciseDetailsData?.title,
            textStyle: themeData.textTheme.headline1,
          ),
          leading: IconButton(
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: AppColor.black,
            ),
            onPressed: () {
              if (!_detailsExerciseViewModel.isStartVideo &&
                  _detailsExerciseViewModel.isEndVideo) {
                Get.back();
              } else {
                showCustomDialog();
              }

              Logger().d(_detailsExerciseViewModel.timeExercise);
            },
          ),
        ),
        body: GetBuilder<DetailsExerciseViewModel>(builder: (logic) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(
              //     width: double.infinity,
              //     child: Image(image: AssetImage(AppMedia.exircise_one))),
              VideoPlayer(
                videoUrl:
                    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                onVideoChangeCallback: (controller) {
                  controller.addListener(() => checkVideo(controller));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: AppPadding.p20,
                    left: AppPadding.p20,
                    top: AppPadding.p60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => onDoneClick(logic),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(logic.isExerciseDone!
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off),
                          const SizedBox(
                            width: AppSize.s12,
                          ),
                          CustomTextView(
                            txt: AppStrings.iFinishedExcercise.tr,
                            textStyle: themeData.textTheme.headline5,
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => onRemindClick(logic),
                      child: Row(
                        children: [
                          Icon(logic.remindMeToRepeatExercise!
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off),
                          const SizedBox(
                            width: AppSize.s12,
                          ),
                          CustomTextView(
                            txt: AppStrings.rememberMeToRepeatExcercise.tr,
                            textStyle: themeData.textTheme.headline5,
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  border: Border.all(
                                      color: AppColor.black,
                                      style: BorderStyle.solid,
                                      width: 1.0)),
                              width: AppSize.s50,
                              height: AppSize.s50,
                              child: Center(
                                  child: CustomTextView(
                                txt: '0',
                                textStyle: themeData.textTheme.headline1,
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomTextView(
                                txt: AppStrings.hour.tr,
                                textStyle: themeData.textTheme.headline1,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: AppSize.s20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: CustomTextView(
                            txt: ':',
                            textStyle: themeData.textTheme.headline5,
                          ),
                        ),
                        const SizedBox(
                          width: AppSize.s20,
                        ),
                        //for Hour timer
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  border: Border.all(
                                      color: AppColor.black,
                                      style: BorderStyle.solid,
                                      width: 1.0)),
                              width: AppSize.s50,
                              height: AppSize.s50,
                              child: Center(
                                  child: CustomTextView(
                                txt: '0',
                                textStyle: themeData.textTheme.headline1,
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomTextView(
                                txt: AppStrings.minute.tr,
                                textStyle: themeData.textTheme.headline1,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void showCustomDialog() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      showAnimatedDialog(GlobalDialogWidget(
        title: AppStrings.txtAttentions.tr,
        subTitle: AppStrings.txtAttentionsHint.tr,
        isLoading: false,
        isTwoBtn: true,
        onCancelBtnClick: () => Get.back(),
        onOkBtnClick: () {
          Get.back();
          Get.back();
        },
      ));
    });
  }

  void checkVideo(videoPlayerController) {
    // Implement your calls inside these conditions' bodies :
    _detailsExerciseViewModel.onVideoChange(videoPlayerController);
  }

  onDoneClick(DetailsExerciseViewModel logic) {

    if (!_detailsExerciseViewModel.isStartVideo &&
        _detailsExerciseViewModel.isEndVideo) {
      logic.isDoneChange();
      if(logic.isExerciseDone!) {
        logic.addEventExercises(widget.exerciseDetailsData?.id, ConstanceNetwork.typeDoneKey);
      }
    }else{
      showCustomDialogNotComplete();
    }
  }

  onRemindClick(DetailsExerciseViewModel logic) {
    logic.isRemindChange();
  }

  void showCustomDialogNotComplete() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      showAnimatedDialog(GlobalDialogWidget(
        title: AppStrings.txtAttentions.tr,
        subTitle: AppStrings.txtAttentionsHintNotComplete.tr,
        isLoading: false,
        isTwoBtn: false,
        onOkBtnClick: () => Get.back(),
      ));
    });
  }
}

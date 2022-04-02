import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/util/app_media.dart';

import '../../../../util/app_color.dart';
import '../../../../util/app_dimen.dart';
import '../../../../util/app_strings.dart';

// ignore: must_be_immutable
class CategoryExerciseView extends StatelessWidget {
  String? exerciseTitle = '';
  int val = -1;
  bool _isExerciseDone = false;
  bool? _remindMetoRepeatExercise = false;
  int? exeirciseHour = 3;
  int? exeirciseMinutes = 25;
  CategoryExerciseView({Key? key, @required this.exerciseTitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColor.lightBlue,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppColor.white,
        title: CustomTextView(
          txt: exerciseTitle,
          textStyle: themeData.textTheme.headline1,
        ),
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: AppColor.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Image(image: AssetImage(AppMedia.exircise_one))),
          Padding(
            padding: const EdgeInsets.only(right: AppPadding.p100, left: AppPadding.p100,top: AppPadding.p100),
            child: Column(
              children: [
                RadioListTile(
                  selected: _isExerciseDone,
                  value: 1,
                  groupValue: val,
                  onChanged: (value) {
                    // ignore: todo
                    //TODO:
                    // val = value;
                    _isExerciseDone = true;
                  },
                  title: CustomTextView(
                    txt: AppStrings.iFinishedExcercise,
                    textStyle: themeData.textTheme.headline5,
                    textAlign: TextAlign.right,
                  ),
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: const EdgeInsets.all(0),
                ),
                RadioListTile(
                  selected: _remindMetoRepeatExercise!,
                  value: 1,
                  groupValue: val,
                  activeColor: AppColor.black,
                  onChanged: (value) {
                    // ignore: todo
                    //TODO:
                    // val = value;
                    _remindMetoRepeatExercise = true;
                  },
                  title: CustomTextView(
                    txt: AppStrings.rememberMeToRepeatExcercise.tr,
                    textStyle: themeData.textTheme.headline5,
                    textAlign: TextAlign.right,
                  ),
                  // this for convert box direction
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: const EdgeInsets.all(0),
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
                            txt: '$exeirciseHour',
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
                          width:  AppSize.s50,
                          height: AppSize.s50,
                          child: Center(
                              child: CustomTextView(
                            txt: '$exeirciseMinutes',
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
      ),
    );
  }
}

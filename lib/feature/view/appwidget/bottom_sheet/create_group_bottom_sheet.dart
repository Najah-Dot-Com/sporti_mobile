import 'package:flutter/material.dart';
import 'package:sporti/feature/view/appwidget/custom_text_filed.dart';
import 'package:sporti/feature/viewmodel/admin_view_model.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/constance.dart';

import '../custome_text_view.dart';
import '../primary_button.dart';
import 'package:get/get.dart';

class CreateGroupBottomSheet extends StatefulWidget {
  const CreateGroupBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateGroupBottomSheet> createState() => _CreateGroupBottomSheetState();
}

class _CreateGroupBottomSheetState extends State<CreateGroupBottomSheet> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode descFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return GetBuilder<AdminViewModel>(
        init: AdminViewModel(),
        builder: (logic) {
          return Container(
            // height: sizeH300,
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSize.s20))),
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: AppSize.s28),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: AppSize.s4,
                    width: AppSize.s50,
                    decoration: BoxDecoration(
                        color: AppColor.grey,
                        borderRadius: BorderRadius.circular(AppSize.s4)),
                  ),
                ),
                const SizedBox(height: AppSize.s28),
                CustomTextView(
                  txt: AppStrings.txtCreateForum.tr,
                  textAlign: TextAlign.center,
                  textStyle: themeData.textTheme.headline2,
                ),
                const SizedBox(height: AppSize.s28),
                CustomTextFormFiled(
                  label: AppStrings.txtNameForum.tr,
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  maxLine: Constance.maxLineOne,
                  focusNode: nameFocus,
                  nexFocusNode: descFocus,
                ),
                const SizedBox(height: AppSize.s28),
                CustomTextFormFiled(
                  label: AppStrings.txtDescForum.tr,
                  controller: descController,
                  maxLength: 200,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  maxLine: Constance.maxLineOne,
                  focusNode: descFocus,
                ),
                const SizedBox(height: AppSize.s28),
                PrimaryButton(
                  isLoading: logic.isLoading,
                  textButton: AppStrings.txtOk.tr,
                  colorText: AppColor.white,
                  colorBtn: AppColor.primary,
                  width: double.infinity,
                  onClicked: () => _createPost(logic),
                ),
                const SizedBox(
                  height: AppSize.s30,
                )
              ],
            ),
          );
        });
  }

  _createPost(AdminViewModel logic) {
    logic.createPost(nameController , descController);
  }
}

import 'package:flutter/material.dart';
import 'package:sporti/feature/view/appwidget/custom_text_filed.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/feature/view/views/money_collect/money_collect_view.dart';
import 'package:sporti/feature/viewmodel/auth_viewmodle.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';
import 'package:sporti/util/constance.dart';
import 'package:sporti/util/sh_util.dart';

class MoneyGiftView extends StatelessWidget {
  const MoneyGiftView({Key? key}) : super(key: key);

  static final FocusNode _emailFocusNode = FocusNode();
  static final FocusNode _noteFocusNode = FocusNode();

  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _noteController = TextEditingController();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  PreferredSizeWidget myAppbar(ThemeData themeData) =>
      AppBar(
        centerTitle: true,
        backgroundColor: AppColor.white,
        leading: InkWell(onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_ios, color: AppColor.black,)),
        title: CustomTextView(
          textAlign: TextAlign.center,
          txt: AppStrings.txtCongratulations.tr,
          textStyle: themeData.textTheme.headline1?.copyWith(
              color: AppColor.primary),
        ),
      );

  //this for you deserve section [انت تستحق $$]
  Widget rowDeserve(ThemeData themeData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextView(
          textAlign: TextAlign.center,
          txt: AppStrings.txtYouDeserve.tr,
          textStyle: themeData.textTheme.headline3,
        ),
        Container(
          width: AppSize.s120,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(AppSize.s6),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.black),
          ),
          child: CustomTextView(
            textAlign: TextAlign.center,
            txt: " ${formatStringWithCurrency(SharedPref.instance
                .getUserData()
                .balance ?? 0)} ",
            textStyle: themeData.textTheme.subtitle2,
          ),
        ),
        CustomTextView(
          textAlign: TextAlign.center,
          txt: "\$",
          textStyle: themeData.textTheme.headline3,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppbar(themeData),
      body: Column(
        children: [
          const SizedBox(
            height: AppSize.s20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppSize.s60),
                      topRight: Radius.circular(AppSize.s60))),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s40),
                  children: [
                    const SizedBox(
                      height: AppSize.s60,
                    ),
                    rowDeserve(themeData),
                    const SizedBox(
                      height: AppSize.s60,
                    ),
                    CustomTextFormFiled(
                      label: AppStrings.txtEmail.tr,
                      keyboardType: TextInputType.emailAddress,
                      customValid: emailValid,
                      // isBorder: false,
                      // isFill: false,
                      isSmallPaddingWidth: true,
                      textInputAction: TextInputAction.next,
                      maxLine: Constance.maxLineOne,
                      controller: _emailController,
                      onSubmitted: (val) {
                        if (val.isNotEmpty) _noteFocusNode.requestFocus();
                      },
                      focusNode: _emailFocusNode,
                      autoFocus: false,
                      nexFocusNode: _noteFocusNode,
                    ),
                    const SizedBox(
                      height: AppSize.s40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.grey)),
                      child: CustomTextFormFiled(
                        label: AppStrings.txtYorMessage.tr,
                        // keyboardType: TextInputType.text,
                        isBorder: false,
                        isFill: true,
                        isSmallPaddingWidth: true,
                        // textInputAction: TextInputAction.newline,
                        maxLine: 1000,
                        minLine: Constance.maxLineSaven,
                        controller: _noteController,
                        onSubmitted: (val) {
                          if (val.isNotEmpty) hideFocus(context);
                        },
                        focusNode: _noteFocusNode,
                        autoFocus: false,
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: AppSize.s120,
                          child: GetBuilder<AuthViewModel>(
                              init: AuthViewModel(),
                              initState: (state){
                                WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                                  _emailController.text = SharedPref.instance.getUserData().email.toString();
                                });
                              },
                              builder: (logic) {
                            return PrimaryButton(
                                textButton: AppStrings.txtSend.tr,
                                isLoading: logic.isLoading,
                                width: AppSize.s120,
                                onClicked: ()=> _onSendClicked(logic));
                          }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onSendClicked(AuthViewModel logic) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      logic.requestUserBalance(_emailController, _noteController);
    }
  }
}

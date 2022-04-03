import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/feature/view/views/account_success_virefy/account_success_virefy_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_strings.dart';

class ForgetOtpView extends StatefulWidget {
  const ForgetOtpView({Key? key}) : super(key: key);

  @override
  State<ForgetOtpView> createState() => _ForgetOtpViewState();
}

class _ForgetOtpViewState extends State<ForgetOtpView> {
  bool hasError = false;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _pinCodeController =
      TextEditingController();
  static StreamController<ErrorAnimationType>? _errorController;

  @override
  initState() {
    _errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  void dispose() {
    _errorController?.close();
    super.dispose();
  }

  PreferredSizeWidget get myAppbar => AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.black,
          ),
        ),
      );

  Widget _pinCodeWidget(ThemeData themeData) {
    return Form(
      key: _formKey,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
          child: PinCodeTextField(
            autoFocus: true,
            autoDismissKeyboard: true,
            enablePinAutofill: true,
            enableActiveFill: true,
            enabled: true,
            textInputAction: TextInputAction.done,
            onSubmitted: _onCodeSubmit,
            appContext: Get.context!,
            pastedTextStyle: TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.bold,
            ),
            length: 4,
            obscureText: false,
            obscuringCharacter: '*',
            animationType: AnimationType.fade,
            validator: (v) {
              // if (v!.length < 3) {
              //   return AppStrings.fillYourVerificationCode.tr;
              // } else {
              //   return null;
              // }
            },
            pinTheme: PinTheme.defaults(
              selectedColor: AppColor.primary,
              shape: PinCodeFieldShape.box,
              inactiveFillColor: AppColor.white,
              disabledColor: AppColor.white,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: AppSize.s60,
              fieldWidth: AppSize.s50,
              inactiveColor: AppColor.primary,
              // selectedColor: AppColor.primary,
              activeColor: AppColor.primary,
              activeFillColor: hasError ? Colors.orange : AppColor.white,
              selectedFillColor: AppColor.white,
              errorBorderColor: AppColor.white,
            ),
            cursorColor: Colors.black,
            animationDuration: const Duration(milliseconds: 300),
            textStyle: const TextStyle(fontSize: AppFontSize.s20, height: 1.6),
            backgroundColor: AppColor.transparent,
            // enableActiveFill: true,
            errorAnimationController: _errorController,
            controller: _pinCodeController,
            keyboardType: TextInputType.number,
            // boxShadows: const [
            //   BoxShadow(
            //     offset: Offset(0, 1),
            //     color: Colors.black12,
            //     blurRadius: 10,
            //   )
            // ],
            onCompleted: _onCodeComplete,
            onChanged: _onChangeCode,
            beforeTextPaste: _beforeTextPaste,
          )),
    );
  }


  //this for verifications code
  Widget _resendVerificationsCode(ThemeData themeData) {
    return RichText(
      text: TextSpan(
          text: "${AppStrings.txtResend.tr} ",
          children: [
            TextSpan(
                text: AppStrings.txtVerifyCode.tr,
                style: themeData.textTheme.headline2?.copyWith(color: AppColor.primary)),
          ],
          style: themeData.textTheme.headline2),
      textAlign: TextAlign.center,
    );
  }
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: myAppbar,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
        children: [
          const SizedBox(
            height: AppSize.s50,
          ),
          CustomTextView(
            txt: AppStrings.txtVerifyCode.tr,
            textStyle: themeData.textTheme.headline1
                ?.copyWith(fontSize: AppFontSize.s28, color: AppColor.primary),
          ),
          const SizedBox(
            height: AppSize.s12,
          ),
          CustomTextView(
            txt: AppStrings.txtVerifyCodeHint.tr,
            textStyle: themeData.textTheme.headline2
                ?.copyWith(fontSize: AppFontSize.s24, color: AppColor.grey),
          ),
          const SizedBox(
            height: AppSize.s12,
          ),
          CustomTextView(
            txt: "555555555",
            textStyle: themeData.textTheme.headline2
                ?.copyWith(fontSize: AppFontSize.s18, color: AppColor.primary),
          ),
          const SizedBox(
            height: AppSize.s100,
          ),
          _pinCodeWidget(themeData),
          const SizedBox(
            height: AppSize.s60,
          ),
          PrimaryButton(
              textButton: AppStrings.txtVerify.tr,
              isLoading: false,
              onClicked: _onVerifyClick),
          const SizedBox(
            height: AppSize.s28,
          ),
          _resendVerificationsCode(themeData),
        ],
      ),
    );
  }



  void _onVerifyClick() {
    Get.to(()=>const AccountSuccessVerifyView());
  }

  // this for on complete code
  void _onCodeComplete(String value) {}

  // this for on Change code
  void _onChangeCode(String value) {}

  bool _beforeTextPaste(String? text) {
    print("Allowing to paste $text");
    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
    //but you can show anything you want here, like your pop up saying wrong paste format or etc
    return true;
  }

  void _onCodeSubmit(String value) {

  }
}

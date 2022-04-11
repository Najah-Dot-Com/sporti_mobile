import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/view/appwidget/custom_text_filed.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/appwidget/primary_button.dart';
import 'package:sporti/feature/view/views/account_otp/account_otp_view.dart';
import 'package:sporti/feature/viewmodel/auth_viewmodle.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/constance.dart';

class AccountVerifyView extends StatelessWidget {
  AccountVerifyView({Key? key}) : super(key: key);

  static final TextEditingController _phoneNumberController =
      TextEditingController();
  String counteryCode = "";
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  //this for phone number widget
  Widget _phoneNumberWidget(ThemeData themeData) {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CountryCodePicker(
            onChanged: _onChangeCountryCode,
            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            initialSelection: 'KW',
            favorite: const ['+965', 'KW', '+970', 'PS'],
            // optional. Shows only country name and flag
            showCountryOnly: false,
            // optional. Shows only country name and flag when popup is closed.
            showOnlyCountryWhenClosed: false,
            // optional. aligns the flag and the Text left
            padding: const EdgeInsets.only(top: AppPadding.p12,left: AppPadding.p18),
            alignLeft: false,

          ),
          // const SizedBox(
          //   width: AppSize.s12,
          // ),
          Expanded(
              child: CustomTextFormFiled(
            controller: _phoneNumberController,
            label: AppStrings.txtMobileNumber.tr,
            isSmallPaddingWidth: true,
            keyboardType: TextInputType.phone,
            maxLine: Constance.maxLineOne,
            textInputAction: TextInputAction.done,
            customValid: phoneVaild,
            onSubmitted: (value) {
              if (value.isNotEmpty) hideFocus(Get.context);
            },
          )),
        ],
      ),
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
            txt: AppStrings.txtVerifyAccount.tr,
            textStyle: themeData.textTheme.headline1
                ?.copyWith(fontSize: AppFontSize.s28, color: AppColor.primary),
          ),
          const SizedBox(
            height: AppSize.s12,
          ),
          CustomTextView(
            txt: AppStrings.txtEnterYourMobileNumber.tr,
            textStyle: themeData.textTheme.headline2
                ?.copyWith(fontSize: AppFontSize.s24, color: AppColor.grey),
          ),
          const SizedBox(
            height: AppSize.s100,
          ),
          _phoneNumberWidget(themeData),
          const SizedBox(
            height: AppSize.s60,
          ),
          PrimaryButton(
              textButton: AppStrings.txtSend.tr,
              isLoading: false,
              onClicked: _onSendClick),
        ],
      ),
    );
  }

  void _onChangeCountryCode(CountryCode value) {
    Logger().i("country code " '$value');
    counteryCode = value.toString();
    Logger().i("counteryCode " '$value');
  }

  void _onSendClick() {
    _formKey.currentState!.validate();
    String userPhoneNumAndCode = '$counteryCode${_phoneNumberController.text.toString()}';
    Logger().i('userPhoneNumAndCode : $userPhoneNumAndCode');
    AuthViewModel().verifyAccount(userPhoneNumber: userPhoneNumAndCode);
  }
}

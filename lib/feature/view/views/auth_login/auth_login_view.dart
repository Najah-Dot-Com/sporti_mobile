import 'package:flutter/material.dart';
import 'package:sporti/feature/view/views/auth_login/widget/widget.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/app_style.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  bool acceptPolicy = false;
  //this for checkBox Style
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.black;
    }
    return Colors.black;
  }

  // small white logo for login screen
  Widget get whiteLogo {
    return const Center(
      child: SizedBox(
        width: 120,
        height: 120,
        child: Image(
          image: AssetImage(AppMedia.sportiWhiteLogo),
        ),
      ),
    );
  }

  //this for login "welcome" and "choose language" text.
  Widget helloTextRow = Center(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(
        AppStrings.chooseLanguage,
        style: AppTextStyle.getBoldStyle(color: Colors.white, fontSize: 16.0),
      ),
      Text(
        AppStrings.hello,
        style: AppTextStyle.getBoldStyle(color: Colors.white, fontSize: 24.0),
      ),
    ],
  ));
  //this for privacy,terms and checkBox Row
  Widget termsAndPrivacyRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
            onTap: () {
              //TODO: GO TO PrivacyPolicy screen
              //Get.to(() => const PrivacyPolicy());
            },
            child: Text(AppStrings.privacyAndTerms,
                style: AppTextStyle.getMediumStyle(
                    color: AppColor.primary, fontSize: AppFontSize.s20))),
        const SizedBox(
          width: 5,
        ),
        const Text(AppStrings.iAccept,
            style: TextStyle(color: Colors.black, fontSize: 14)),
        Checkbox(
            fillColor: MaterialStateProperty.resolveWith(getColor),
            checkColor: Colors.white,
            value: acceptPolicy,
            onChanged: (value) {
              // ignore: todo
              //TODO :need for state
              // setState(() {
              //   acceptPolicy = value!;
              // });
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.primary,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColor.primary,
          title: Column(
            children: [
              whiteLogo,
              const SizedBox(height: AppSize.s20),
              helloTextRow,
            ],
          ),
          toolbarHeight: 220,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: AppSize.s20,
              ),
              Container(
                width: double.infinity,
                height: 700,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: AppPadding.p100,
                        left: AppPadding.p50,
                        right: AppPadding.p50,
                        bottom: AppPadding.p20),
                    child: Column(
                      children: [
                        //this for username TextFiled
                        sportiTextFiled(
                          hint: AppStrings.username,
                          isforPass: false,
                        ),
                        const SizedBox(height: AppSize.s50),
                        //this for password TextFiled
                        sportiTextFiled(
                          hint: AppStrings.password,
                          isforPass: true,
                        ),
                        //this for checkBox of terms and policy
                        termsAndPrivacyRow(),
                        const SizedBox(
                          height: AppSize.s28,
                        ),
                        //this btn for signin
                        SignInButton(
                          height: 60,
                          label: AppStrings.signin,
                          width: 350,
                          primaryColor: AppColor.primary,
                          labelcolor: AppColor.white,
                          borderColor: AppColor.primary,
                        ),
                        const SizedBox(
                          height: AppSize.s50,
                        ),
                        Text(
                          AppStrings.or,
                          style: AppTextStyle.getSemiBoldStyle(
                              color: AppColor.black, fontSize: AppFontSize.s22),
                        ),
                        const SizedBox(
                          height: AppSize.s50,
                        ),
                        //this btn for new signup
                        SignInButton(
                          height: 60,
                          label: AppStrings.newSignin,
                          width: 350,
                          primaryColor: AppColor.white,
                          labelcolor: AppColor.primary,
                          borderColor: AppColor.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // this for login textField name and password
  TextField sportiTextFiled(
      {@required String? hint, @required bool? isforPass}) {
    const Color eyeIconColor = Colors.grey;
    const bool obsecurPass = false;
    return TextField(
      style: const TextStyle(color: Colors.black, fontSize: 18),
      keyboardType: isforPass == false
          ? TextInputType.name
          : TextInputType.visiblePassword,
      obscureText: isforPass == true ? true : false,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red[400]!,
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: AppFontSize.s16),
        hintTextDirection: TextDirection.rtl,
        prefixIcon: isforPass == false
            ? const SizedBox()
            : IconButton(
                icon: const Icon(
                  Icons.remove_red_eye_rounded,
                  color: eyeIconColor,
                ),
                onPressed: () {
                  // ignore: todo
                  //TODO: need for state here
                  obsecurPass == false ? true : false;
                  eyeIconColor == Colors.grey
                      ? Icons.remove_red_eye_rounded
                      : Colors.grey;
                },
              ),
      ),
    );
  }
}

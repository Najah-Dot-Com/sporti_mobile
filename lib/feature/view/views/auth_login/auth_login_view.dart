import 'package:flutter/material.dart';
import 'package:sporti/util/app_color.dart';
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
              const SizedBox(height: 20),
              helloTextRow,
            ],
          ),
          toolbarHeight: 220,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 530,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 100.0, left: 50, right: 50, bottom: 20),
                    child: Column(
                      children: [
                        //this for username TextFiled
                        sportiTextFiled(
                          hint: AppStrings.username,
                          isforPass: false,
                        ),
                        const SizedBox(height: 20),
                        //this for password TextFiled
                        sportiTextFiled(
                          hint: AppStrings.password,
                          isforPass: true,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  //Get.to(() => const PrivacyPolicy());
                                },
                                child: const Text(
                                  'الشروط والاحكام',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 13),
                                )),
                            const Text('أوافق على',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14)),
                            const SizedBox(
                              width: 5,
                            ),
                            Checkbox(
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                checkColor: Colors.white,
                                value: acceptPolicy,
                                onChanged: (value) {
                                  //TODO :need for state
                                  // setState(() {
                                  //   acceptPolicy = value!;
                                  // });
                                }),
                          ],
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
        hintStyle: const TextStyle(fontSize: 15),
        hintTextDirection: TextDirection.rtl,
        prefixIcon: isforPass == false
            ? const SizedBox()
            : IconButton(
                icon: const Icon(
                  Icons.remove_red_eye_rounded,
                  color: eyeIconColor,
                ),
                onPressed: () {
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

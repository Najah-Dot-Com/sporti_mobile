import 'package:flutter/material.dart';
import 'package:sporti/util/app_dimen.dart';
import '../../../util/app_color.dart';
import '../../../util/app_font.dart';

// ignore: must_be_immutable
class SportiTextField extends StatelessWidget {
  Color eyeIconColor = Colors.grey;
  bool obsecurPass = false;
  bool? isforPass = false;
  String? hint = '';
  TextInputType? textInputType;
  TextEditingController? controller;
  SportiTextField({
    Key? key,
    @required this.hint,
    @required this.isforPass,
    @required this.controller,
    @required this.textInputType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black, fontSize: 18),
      keyboardType: textInputType ?? TextInputType.text,
      obscureText: isforPass == true ? true : false,
      textAlign: hint!.contains('a') == true
          ? TextAlign.left
          : TextAlign.left, //TODO: dependes on language
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(AppPadding.p20),
          hintTextDirection: hint!.contains('a') == true
              ? TextDirection.ltr
              : TextDirection.rtl, //TODO: dependes on language
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
          prefixIcon: isforPass == true
              ? IconButton(
                  icon: Icon(
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
                )
              : null),
    );
  }
}

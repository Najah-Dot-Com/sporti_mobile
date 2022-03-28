import 'package:flutter/material.dart';

import '../../../util/app_color.dart';
import '../../../util/app_font.dart';

// ignore: must_be_immutable
class SportiTextField extends StatelessWidget {
  Color eyeIconColor = Colors.grey;
  bool obsecurPass = false;
  bool? isforPass = false;
  String? hint = '';
  TextEditingController? controller;
  SportiTextField({Key? key, @required this.hint, @required this.isforPass,@required this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {  
    return TextField(
      controller: controller,
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
              ),
      ),
    );
  }
}

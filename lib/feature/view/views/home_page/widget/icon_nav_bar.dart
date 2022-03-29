import 'package:flutter/material.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';
class IconNavBar extends StatelessWidget {
  const IconNavBar({Key? key,required this.title,required this.icon,required this.color,required this.onIconClick}) : super(key: key);
  final String? title;
  final IconData? icon;
  final Color? color;
  final Function()? onIconClick;
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return MaterialButton(
      onPressed: onIconClick,
      minWidth: AppSize.s48,
      child: Column(
        mainAxisSize:MainAxisSize.min ,
        children: [
          Icon(
            icon,
            size: AppSize.s28,
            color: color,
          ),
          const SizedBox(height: AppSize.s10,),
          CustomTextView(
            txt: title??AppStrings.txtHome.tr,
            textStyle: themeData.textTheme.headline3?.copyWith(color:color , fontSize: AppFontSize.s10 ),
          )
        ],
      ),
    );
  }
}

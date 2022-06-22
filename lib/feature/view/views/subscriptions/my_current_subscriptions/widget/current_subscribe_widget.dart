import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sporti/feature/model/plan_data.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';

class CurrentSubscribeWidget extends StatelessWidget {
  const CurrentSubscribeWidget({Key? key,required this.currentSubscriptions, }) : super(key: key);//CurrentSubscribe
  final PlanData currentSubscriptions;
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: AppSize.s40),
          padding: const EdgeInsets.all(AppSize.s33),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(AppPadding.p16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: AppSize.s30,
              ),
              CustomTextView(
                txt: currentSubscriptions.name,
                textStyle: themeData.textTheme.headline1
                    ?.copyWith(color: AppColor.black),
              ),
              const SizedBox(
                height: AppSize.s16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextView(
                    txt: "${currentSubscriptions.price} / ",
                    textStyle: themeData.textTheme.headline1
                        ?.copyWith(color: AppColor.primary),
                  ),
                  CustomTextView(
                    txt: "${currentSubscriptions.period}",
                    textStyle: themeData.textTheme.headline3
                        ?.copyWith(color: AppColor.black),
                  ),
                ],
              ),
              const SizedBox(
                height: AppSize.s30,
              ),
              CustomTextView(
                textAlign: TextAlign.center,
                txt:
                "${currentSubscriptions.description}",
                textStyle: themeData.textTheme.headline2
                    ?.copyWith(color: AppColor.black, height: AppSize.s1_5),
              ),
            ],
          ),
        ),
        Center(child: SvgPicture.asset(AppMedia.subscriptionsLarge)),
      ],
    );
  }
}

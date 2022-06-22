import 'package:flutter/material.dart';
import 'package:sporti/feature/model/plan_data.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_style.dart';

class PlanItemWidget extends StatelessWidget {
  const PlanItemWidget({
    Key? key,
    required this.planData,required this.isSelectedIndex,
  }) : super(key: key);
  final PlanData planData;
  final bool isSelectedIndex;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSize.s20,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.s10),
        border: Border.all(color: isSelectedIndex ?AppColor.primary : AppColor.scaffold),
        boxShadow: [AppShadow.boxShadowLight()!],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: AppSize.s10, right: AppSize.s10),
                child: CustomTextView(
                  txt: planData.name.toString(),
                  textStyle: themeData.textTheme.headline2?.copyWith(
                    color: isSelectedIndex ?AppColor.primary : AppColor.black,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12, vertical: AppPadding.p5),
                alignment: Alignment.center,
                height: AppSize.s35,
                decoration: BoxDecoration(
                  color: isSelectedIndex ?AppColor.primary : AppColor.scaffold,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(AppPadding.p9),
                    topLeft: Radius.circular(AppPadding.p3),
                    bottomRight: Radius.circular(AppPadding.p3),
                    bottomLeft: Radius.circular(AppPadding.p3),
                  ),
                ),
                child: CustomTextView(
                  txt: "${planData.price} / ${planData.period}",
                  textStyle: themeData.textTheme.headline3?.copyWith(
                      color: isSelectedIndex ?AppColor.white : AppColor.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          CustomTextView(
            textAlign: TextAlign.center,
            txt: planData.description,
            textStyle: themeData.textTheme.headline2
                ?.copyWith(color: AppColor.black, height: AppSize.s1_5),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
        ],
      ),
    );
  }
}

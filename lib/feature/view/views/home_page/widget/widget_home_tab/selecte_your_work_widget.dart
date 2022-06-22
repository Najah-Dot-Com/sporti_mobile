import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sporti/feature/model/exercises_package_data.dart';
import 'package:sporti/feature/view/appwidget/bottom_sheet/gloable_bottom_sheet.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/category_details/categories_details_view.dart';
import 'package:sporti/feature/viewmodel/home_viewmodel.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/constance.dart';

class SelectYourWorkWidget extends StatelessWidget {
  const SelectYourWorkWidget({
    Key? key,
    this.package,
  }) : super(key: key);
  final ExercisesData? package;
  final String fakeImage =
      "https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/07/1377301-1183869-The-8-Best-Weight-Benches-of-2021-1296x728-Header-c0dcdf.jpg?w=1575";

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return InkWell(
      onTap: _onItemClick,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: AppSize.s10),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSize.s12, vertical: AppSize.s10),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: AppSize.s85,
              height: AppSize.s85,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppSize.s6),
                    width: AppSize.s76,
                    height: AppSize.s76,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s12)),
                    child: Stack(
                      children: [
                        imageNetwork(
                            width: AppSize.s150,
                            height: AppSize.s120,
                            fit: BoxFit.cover,
                            url: "${ConstanceNetwork.baseImageExercises}${package?.image?[0] ?? fakeImage}"),
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 0,
                    end: 0,
                    child: InkWell(
                      onTap: _onAddToMyWork,
                      child: SvgPicture.asset(
                        package!.isFavorite!
                            ? AppMedia.remove
                            : AppMedia.iconsAdd,
                        width: package!.isFavorite! ? AppSize.s28 : AppSize.s35,
                        height:
                            package!.isFavorite! ? AppSize.s28 : AppSize.s35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: AppSize.s20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextView(
                    txt: package?.title.toString(),
                    maxLine: Constance.maxLineOne,
                    textOverflow: TextOverflow.ellipsis,
                    textStyle: themeData.textTheme.headline2?.copyWith(
                        color: AppColor.black, fontSize: AppFontSize.s16),
                  ),
                  const SizedBox(
                    height: AppSize.s6,
                  ),
                  CustomTextView(
                    txt: package?.description.toString(),
                    maxLine: Constance.maxLineOne,
                    textOverflow: TextOverflow.ellipsis,
                    textStyle: themeData.textTheme.subtitle2
                        ?.copyWith(color: AppColor.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: AppSize.s20,
            ),
            CustomTextView(
              txt: _handleTimePackage(),
              textStyle: themeData.textTheme.subtitle2
                  ?.copyWith(color: AppColor.grey, fontSize: AppFontSize.s16),
            ),
            const SizedBox(
              width: AppSize.s20,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColor.grey,
            ),
          ],
        ),
      ),
    );
  }

  void _onAddToMyWork() async {
    await showIsVerifyDialog(isNeedSubscriptions: true).then((value) {
      if (value) {
        Get.bottomSheet(
            GetBuilder<HomeViewModel>(
                init: HomeViewModel(),
                builder: (logic) {
                  return GlobalBottomSheet(
                    title: AppStrings.txtAddToMyWork.tr,
                    isLoading: logic.isLoadingAddMyWork,
                    onOkBtnClick: () {
                      logic.addToMyWork(package?.id.toString());
                    },
                    onCancelBtnClick: () => Get.back(),
                  );
                }),
            isScrollControlled: true);
      }
    });
  }

  void _onItemClick() {
    Get.to(CategoriesDetailsView(
      id: package?.id.toString(),
      title: package?.title.toString(),
      package: package,
    ));
  }

  String _handleTimePackage() {
    if(package?.time != null && package!.time! < 60) {
      return "${package?.time.toString()}"+ " " + AppStrings.seconds.tr;
    }else if(package?.time != null && package!.time! >= 60) {
      return "${(package!.time! / 60).round()}"+ " " + AppStrings.minute.tr.substring(0,3);
    }
    return  "${package?.time.toString()}"+ " " + AppStrings.seconds.tr;
  }

}

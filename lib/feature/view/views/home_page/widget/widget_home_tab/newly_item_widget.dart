import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sporti/feature/model/exercises_package_data.dart';
import 'package:sporti/feature/view/appwidget/bottom_sheet/gloable_bottom_sheet.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/category_details/categories_details_view.dart';
import 'package:sporti/feature/viewmodel/home_viewmodel.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';

class NewlyItemWidget extends StatelessWidget {
  const NewlyItemWidget({
    Key? key, this.packages,
  }) : super(key: key);

  final ExercisesData? packages;
  final String fakeImage =
      "https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/07/1377301-1183869-The-8-Best-Weight-Benches-of-2021-1296x728-Header-c0dcdf.jpg?w=1575";

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return InkWell(
      onTap: _onItemClick,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSize.s6),
            width: AppSize.s150,
            height: AppSize.s120,
            clipBehavior: Clip.hardEdge,
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s30)),
            child: Stack(
              children: [
                imageNetwork(
                    width: AppSize.s150,
                    height: AppSize.s120,
                    fit: BoxFit.cover,
                    url: "${ConstanceNetwork.baseImageExercises}${packages?.image?[0] ?? fakeImage}"),
                SvgPicture.asset(AppMedia.transparentImage),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomTextView(
                      txt: packages?.title.toString(),
                      textAlign: TextAlign.center,
                      textStyle: themeData.textTheme.headline2
                          ?.copyWith(color: AppColor.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: AppSize.s6,
            end: 0,
            child: InkWell(
                onTap: _onAddToMyWork,
                child: SvgPicture.asset(packages!.isFavorite! ? AppMedia.remove:AppMedia.iconsAdd,
                  width:packages!.isFavorite!? AppSize.s28:AppSize.s35 , height: packages!.isFavorite!?AppSize.s28:AppSize.s35 ,),),
          ),
        ],
      ),
    );
  }

  void _onAddToMyWork() async{
   await showIsVerifyDialog(isNeedSubscriptions: true).then((value) {
      if(value){
        Get.bottomSheet(GetBuilder<HomeViewModel>(
            init: HomeViewModel(),
            builder: (logic) {
              return GlobalBottomSheet(
                title:AppStrings.txtAddToMyWork.tr,
                isLoading: logic.isLoadingAddMyWork,
                onOkBtnClick: () {
                  logic.addToMyWork(packages?.id.toString());
                },
                onCancelBtnClick: () => Get.back(),
              );
            }), isScrollControlled: true);
      }
    });

  }

  void _onItemClick() {
    Get.to(CategoriesDetailsView(
      id: packages?.id.toString(), title: packages?.title.toString(),package:packages));
  }
}

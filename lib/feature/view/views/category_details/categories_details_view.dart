import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/exercises_package_data.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/category_details/widget/categories_list_item_widget.dart';
import 'package:sporti/feature/view/views/category_details/widget/shimmer_categories_list_item_widget.dart';
import 'package:sporti/feature/viewmodel/home_viewmodel.dart';
import 'package:sporti/network/utils/constance_netwoek.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';
import 'package:sporti/util/app_style.dart';
import 'package:sporti/util/constance.dart';
import 'package:sporti/util/sh_util.dart';

class CategoriesDetailsView extends StatelessWidget {
  const CategoriesDetailsView(
      {Key? key, required this.title, required this.id, required this.package,})
      : super(key: key);
  final String? title;
  final String? id;
  final ExercisesData? package;

  final String fakeImage =
      "https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/07/1377301-1183869-The-8-Best-Weight-Benches-of-2021-1296x728-Header-c0dcdf.jpg?w=1575";

  PreferredSizeWidget myAppbar(ThemeData themeData) =>
      AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: CustomTextView(
          txt: title,
          textStyle:
          themeData.textTheme.headline2?.copyWith(color: AppColor.black),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.black,
          ),
        ),
      );

  Widget myPackageList(HomeViewModel logic) {
    if (logic.isLoading) {
      return ListView.builder(
          itemCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return const ShimmerCategoriesListItemWidget();
          });
    } else if (!logic.isLoading && logic.packageDetailsExercisesList.isEmpty) {
      //todo:// here we will add empty state widget
      return const SizedBox.shrink();
    }
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: logic.packageDetailsExercisesList.length,
        itemBuilder: (context, index) {
          return CategoriesListItemWidget(
              packageDetails: logic.packageDetailsExercisesList[index] , viewModel:logic);
        });
  }



  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: myAppbar(themeData),
      floatingActionButton: GetBuilder<HomeViewModel>(builder: (logic) {
        if(logic.packageDetailsExercisesList.isEmpty){
          return const SizedBox.shrink();
        }
        var packages = logic.exercisesListAll.firstWhere((element) {
          return element.id.toString() == id.toString();
        });
        return logic.isLoading ? const SizedBox.shrink():FloatingActionButton(
          backgroundColor: packages.isFavorite! ? AppColor.error : AppColor
              .primary,
          onPressed: ()=>_onAddBtnClick(logic),
          child: Icon(
            packages.isFavorite! ? Icons.remove : Icons.add,
            color: AppColor.white,
          ),
        );
      }),
      body: GetBuilder<HomeViewModel>(
          init: HomeViewModel(),
          initState: (state) {
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              state.controller?.packagesExercisesDetails(id);
            });
          },
          builder: (logic) {
            return SingleChildScrollView(
              physics: AppStyleScroll.customScrollViewIOS(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.s28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSize.s28,
                    ),
                    if(!logic.isLoading)...[
                    CarouselSlider.builder(
                      itemCount: package?.image?.length,
                        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
                        return  imageNetwork(
                            width: double.infinity,
                            height: AppSize.s200,
                            fit: BoxFit.cover,
                            url: "${ConstanceNetwork.baseImageExercises}${package?.image?[itemIndex]??fakeImage}");
                        },
                        options: CarouselOptions(
                          height: AppSize.s400,
                          aspectRatio: AppSize.s16/AppSize.s9,
                          viewportFraction:AppSize.s0_8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(milliseconds: DurationConstant.d800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          onPageChanged: (index , corsule){},
                          scrollDirection: Axis.horizontal,
                        ),
                    ),
                    const SizedBox(
                      height: AppSize.s28,
                    ),
                    CustomTextView(
                      txt: SharedPref.instance.getAppSettings().systemMessage?? AppStrings.txtDetailsNote.tr,
                      textStyle: themeData.textTheme.subtitle2
                          ?.copyWith(color: AppColor.grey),
                    ),
                    ],
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    myPackageList(logic),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _onAddBtnClick(HomeViewModel logic) async{
    await showIsVerifyDialog().then((value) async{
      if(value){
        await logic.addToMyWork(id , isFromDetails: true);
        logic.packagesExercisesDetails(id);
      }
    });

  }
}

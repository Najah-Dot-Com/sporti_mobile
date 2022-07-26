import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/user_data.dart';
import 'package:sporti/feature/view/appwidget/custome_text_view.dart';
import 'package:sporti/feature/view/views/home_page/widget/widget_home_tab/newly_item_widget.dart';
import 'package:sporti/feature/view/views/home_page/widget/widget_home_tab/shimmer_newly_item_widget.dart';
import 'package:sporti/feature/viewmodel/home_viewmodel.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_font.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:get/get.dart';
import 'package:sporti/util/app_style.dart';
import 'package:sporti/util/constance.dart';
import 'package:sporti/util/sh_util.dart';

import 'widget_home_tab/selecte_your_work_widget.dart';
import 'widget_home_tab/shimmer_your_work_widget.dart';

class HomePageTab extends StatelessWidget {
  /*const*/ HomePageTab({Key? key}) : super(key: key);

  static final HomeViewModel _homeViewModel =
      Get.put<HomeViewModel>(HomeViewModel());

  PreferredSizeWidget myAppBar(ThemeData themeData) => AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: CustomTextView(
          txt: AppStrings.txtHello.tr +
              " ${SharedPref.instance.getUserData().fullname} ",
          textStyle:
              themeData.textTheme.headline2?.copyWith(color: AppColor.black),
        ),
        // actions: [
        //   MaterialButton(
        //     onPressed: _onNotificationIconClick,
        //     minWidth: AppSize.s48,
        //     child: Icon(
        //       Icons.notifications_rounded, //feed_outlined
        //       size: AppSize.s24,
        //       color: AppColor.grey,
        //     ),
        //   ),
        // ],
      );

  Widget newlyAdePackage(HomeViewModel logic) {
    if (logic.isLoading) {
      return SizedBox(
        height: AppSize.s140,
        child: ListView.builder(
          itemCount: 7,
          shrinkWrap: true,
          clipBehavior: Clip.hardEdge,
          scrollDirection: Axis.horizontal,
          physics: AppStyleScroll.customScrollViewIOS(),
          itemBuilder: (context, index) {
            return const ShimmerNewlyItemWidget();
          },
        ),
      );
    } else if (!logic.isLoading && logic.exercisesListRecentlyAll.isEmpty) {
      //todo:// here we will add empty state widget
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: AppSize.s140,
      child: ListView.builder(
        itemCount: logic.exercisesListRecentlyAll.length,
        shrinkWrap: true,
        clipBehavior: Clip.hardEdge,
        scrollDirection: Axis.horizontal,
        physics: AppStyleScroll.customScrollViewIOS(),
        itemBuilder: (context, index) {
          try {
            if (logic.exercisesListRecentlyAll[index].countExercises != 0) {
              return NewlyItemWidget(
                  packages: logic.exercisesListRecentlyAll[index]);
            } else {
              return const SizedBox.shrink();
            }
          } catch (e) {
            print(e);
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget selectMyWorkWidget(HomeViewModel logic) {
    if (logic.isLoading) {
      return ListView.builder(
          itemCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return const ShimmerSelectYourWorkWidget();
          });
    } else if (!logic.isLoading && logic.exercisesListAll.isEmpty) {
      //todo:// here we will add empty state widget
      return const SizedBox.shrink();
    }
    return ListView.builder(
        itemCount: logic.exercisesListAll.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          try {
            if (logic.exercisesListAll[index].countExercises != 0) {
              return SelectYourWorkWidget(
                  package: logic.exercisesListAll[index]);
            } else {
              return const SizedBox.shrink();
            }
          } catch (e) {
            print(e);
            return const SizedBox.shrink();
          }
        });
  }
  final String fakeImage =
      "https://i0.wp.com/post.healthline.com/wp-content/uploads/2021/07/1377301-1183869-The-8-Best-Weight-Benches-of-2021-1296x728-Header-c0dcdf.jpg?w=1575";
  var image = [
    "https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
    "https://images.unsplash.com/photo-1556817411-31ae72fa3ea0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
    "https://images.unsplash.com/photo-1530549387789-4c1017266635?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
  ];
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(

      // appBar: myAppBar(themeData),
      body: GetBuilder<HomeViewModel>(
          init: HomeViewModel(),
          initState: (state) {
            WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
              state.controller?.allPackagesExercises();
              state.controller?.allPackagesTopExercises();
              state.controller?.getBalanceUser();
            });
          },
          builder: (logic) {
            UserData? userData = SharedPref.instance.getUserData();
            Logger().d(userData.picture);
            return SingleChildScrollView(
              physics: AppStyleScroll.customScrollViewAndroid(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: AppSize.s150,
                        width: double.infinity,
                        color: AppColor.primary,
                        child: SvgPicture.asset(
                          AppMedia.homeGreenBackground,
                          fit: BoxFit.cover,
                          height: AppSize.s150,
                          width: double.infinity,
                        ),
                      ),
                      PositionedDirectional(
                        top: AppSize.s60,
                        start: AppSize.s50,
                        child: InkWell(
                          onTap: _onProfileIconClick,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                // borderRadius: BorderRadius.circular(AppPadding.p18),
                                child: (userData.picture != null &&
                                        userData.picture!.isNotEmpty &&
                                        !userData.picture!.contains("http"))
                                    ? Image.memory(
                                        base64Decode(userData.picture.toString()),
                                        width: AppSize.s50,
                                        height: AppSize.s50,
                                        fit: BoxFit.cover)
                                    : imageNetwork(
                                        url: (userData.picture != null &&
                                                userData.picture!.isNotEmpty)
                                            ? userData.picture
                                            : null,
                                        width: AppSize.s50,
                                        height: AppSize.s50,
                                        fit: BoxFit.cover),
                              ),
                              const SizedBox(
                                width: AppSize.s12,
                              ),
                              CustomTextView(
                                txt: AppStrings.txtHello.tr +
                                    " ${SharedPref.instance.getUserData().fullname} ",
                                textStyle: themeData.textTheme.headline2
                                    ?.copyWith(color: AppColor.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: AppSize.s140,
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: AppSize.s120,
                            left: AppSize.s12,
                            right: AppSize.s12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSize.s40, vertical: AppSize.s16),
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(AppSize.s12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextView(
                              txt: AppStrings.txtCoins.tr,
                              textStyle: themeData.textTheme.headline2
                                  ?.copyWith(color: AppColor.black),
                            ),
                            const SizedBox(
                              height: AppSize.s20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppMedia.earningIcons,
                                  width: AppSize.s40,
                                  height: AppSize.s40,
                                ),
                                const SizedBox(width: AppSize.s12,),
                                CustomTextView(
                                  txt: /*formatStringWithCurrency(*/SharedPref.instance.getUserData().finish.toString()/*)*/,
                                  textStyle: themeData.textTheme.headline1
                                      ?.copyWith(color: AppColor.primary),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: AppSize.s10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CustomTextView(
                                txt: (AppStrings.txtEqualTo.tr + " " + formatStringWithCurrency(SharedPref.instance.getUserData().balance.toString())),
                                textStyle: themeData.textTheme.headline3
                                    ?.copyWith(color: AppColor.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.s18),
                    child: Row(
                      children: [
                        CustomTextView(
                          txt: "اعلانات",
                          textAlign: TextAlign.start,
                          textStyle: themeData.textTheme.headline2
                              ?.copyWith(color: AppColor.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                  CarouselSlider.builder(
                    itemCount: image.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
                      return  imageNetwork(
                          width: double.infinity,
                          height: AppSize.s200,
                          fit: BoxFit.cover,
                          url: /*fakeImage*/image[itemIndex]);
                    },
                    options: CarouselOptions(
                      height: AppSize.s200,
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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSize.s18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: AppSize.s28,
                        ),
                        CustomTextView(
                          txt: AppStrings.txtNewlyAddedPackages.tr,
                          textStyle: themeData.textTheme.headline2
                              ?.copyWith(color: AppColor.black),
                        ),
                        const SizedBox(
                          height: AppSize.s28,
                        ),
                        newlyAdePackage(logic),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        CustomTextView(
                          txt: AppStrings.txtChooseYourFavoriteExercises.tr,
                          textStyle: themeData.textTheme.headline2
                              ?.copyWith(color: AppColor.black),
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        selectMyWorkWidget(logic),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  void _onNotificationIconClick() {
    _homeViewModel.onTabChange(_homeViewModel.notificationsIndex);
  }

  void _onProfileIconClick() {
    _homeViewModel.onTabChange(_homeViewModel.profileIndex);
  }
}

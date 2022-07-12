import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sporti/feature/model/on_bording_data.dart';
import 'package:sporti/feature/view/views/auth_login/auth_login_view.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_dimen.dart';
import 'package:sporti/util/app_shaerd_data.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/sh_util.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'https://assets4.lottiefiles.com/packages/lf20_18vkvya1.json',
      text: AppStrings.favoritePackageTxt.tr,
      desc: AppStrings.favoritePackageHintTxt.tr,
      bg: Colors.white,
      button: AppColor.primary,
    ),
    OnboardModel(
      img: 'https://assets4.lottiefiles.com/packages/lf20_oncjxjbd.json',
      text: AppStrings.sportiDoTxt.tr ,
      desc: AppStrings.sportiDoHintTxt.tr,
      bg: AppColor.primary,
      button: Colors.white,
    ),
    OnboardModel(
      img: 'https://assets4.lottiefiles.com/packages/lf20_ltuxwdw4.json',
      text: AppStrings.yourCoachTxt.tr,
      desc: AppStrings.yourCoachHintTxt.tr,
      bg: Colors.white,
      button: AppColor.primary,
    ),
    OnboardModel(
      img: 'https://assets2.lottiefiles.com/packages/lf20_OdVhgq.json',
      text: AppStrings.oneMoreTxt.tr,
      desc: AppStrings.oneMoreHintTxt.tr,
      bg: AppColor.primary,
      button: Colors.white,
    ),
    OnboardModel(
      img: 'https://assets8.lottiefiles.com/packages/lf20_ctwlrzmf.json',
      text: AppStrings.subscriptionsTxt.tr,
      desc: AppStrings.subscriptionsHintTxt.tr,
      bg: AppColor.primary,
      button: Colors.white,
    ),
  ];

  Widget _pageItem(int index) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.network(screens[index].img,
                  width: AppSize.s300, height: AppSize.s300, fit: BoxFit.fill),
              const SizedBox(
                height: AppSize.s40,
              ),
              Container(
                height: 10.0,
                child: ListView.builder(
                  itemCount: screens.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.0),
                            width: currentIndex == index ? 25 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? AppColor.black
                                  : AppColor.black.withAlpha(50),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ]);
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s40,
              ),
              Text(
                screens[index].text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: index % 2 == 0 ? AppColor.black : AppColor.white,
                ),
              ),
              const SizedBox(
                height: AppSize.s40,
              ),
              Text(
                screens[index].desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Montserrat',
                  color: index % 2 == 0 ? AppColor.black : AppColor.white,
                ),
              ),
              const SizedBox(
                height: AppSize.s85,
              ),

            ],
          ),
        ),
        PositionedDirectional(
            bottom: AppSize.s85,
            child: InkWell(
              onTap: () async {
                print(index);
                if (index == screens.length - 1) {
                  await _storeOnboardInfo();
                  Get.offAll(LoginView());
                }

                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                decoration: BoxDecoration(
                    color: index % 2 == 0 ? AppColor.primary : AppColor.white,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    AppStrings.txtNext.tr,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: index % 2 == 0 ? AppColor.white : AppColor.primary,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Icon(
                    Icons.arrow_forward_sharp,
                    color: index % 2 == 0 ? AppColor.white : AppColor.primary,
                  )
                ]),
              ),
            )),
      ],
    );
  }
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    initListener();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          currentIndex % 2 == 0 ? AppColor.white : AppColor.primary,
      appBar: AppBar(
        backgroundColor:
            currentIndex % 2 == 0 ? AppColor.white : AppColor.primary,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              _storeOnboardInfo();
              Get.offAll(LoginView());
            },
            child: Text(
              AppStrings.txtSkip.tr,
              style: TextStyle(
                color: currentIndex % 2 == 0 ? AppColor.black : AppColor.white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return _pageItem(index);
            }),
      ),
    );
  }



  _storeOnboardInfo() async {
    SharedPref.instance.setOnBoardingView(true);
  }

  void initListener() {
    var appSettings = SharedPref.instance.getAppSettings();
    _storeOnboardInfo();
    if (appSettings.setting != null && appSettings.setting!.isNotEmpty) {
      screens.clear();
      setState(() {});
      for (int i = 0; i < appSettings.setting!.length; i++) {
        var items = appSettings.setting![i];
        screens.add(OnboardModel(
          img: items.image.toString(),
          text: items.title.toString(),
          desc: items.description.toString(),
          bg: currentIndex % 2 == 0 ? AppColor.white : AppColor.primary,
          button: currentIndex % 2 == 0 ? AppColor.white : AppColor.primary,
        ));
      }
    }
  }
}

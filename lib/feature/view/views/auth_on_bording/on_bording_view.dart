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
      text: "Belajar Dengan Metode Learning by Doing",
      desc:
          "Sebuah metode belajar yang terbuktiampuh dalam meningkatkan produktifitas belajar, Learning by Doing",
      bg: Colors.white,
      button: AppColor.primary,
    ),
    OnboardModel(
      img: 'https://assets4.lottiefiles.com/packages/lf20_oncjxjbd.json',
      text: "Dapatkan Kemudahan Akses Kapanpun dan Dimanapun",
      desc:
          "Tidak peduli dimanapun kamu, semua kursus yang telah kamu ikuti bias kamu akses sepenuhnya",
      bg: AppColor.primary,
      button: Colors.white,
    ),
    OnboardModel(
      img: 'https://assets4.lottiefiles.com/packages/lf20_ltuxwdw4.json',
      text: "Gunakan Fitur Kolaborasi Untuk Pengalaman Lebih",
      desc:
          "Tersedia fitur Kolaborasi dengan tujuan untuk mengasah skill lebih dalam karena bias belajar bersama",
      bg: Colors.white,
      button: AppColor.primary,
    ),
    OnboardModel(
      img: 'https://assets2.lottiefiles.com/packages/lf20_OdVhgq.json',
      text: "Gunakan Fitur Kolaborasi Untuk Pengalaman Lebih",
      desc:
      "Tersedia fitur Kolaborasi dengan tujuan untuk mengasah skill lebih dalam karena bias belajar bersama",
      bg: AppColor.primary,
      button: Colors.white,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.network(screens[index].img , width: AppSize.s300, height:AppSize.s300, fit: BoxFit.fill),
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
                  Text(
                    screens[index].desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Montserrat',
                      color: index % 2 == 0 ? AppColor.black : AppColor.white,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      print(index);
                      if (index == screens.length - 1) {
                        await _storeOnboardInfo();
                        Get.offAll(LoginView());
                      }

                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceIn,
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                      decoration: BoxDecoration(
                          color: index % 2 == 0 ? AppColor.primary : AppColor.white,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          AppStrings.txtNext.tr,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: index % 2 == 0 ? AppColor.white : AppColor.primary,),
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
                  )
                ],
              );
            }),
      ),
    );
  }

  _storeOnboardInfo() async {
    SharedPref.instance.setOnBoardingView(true);
  }
}

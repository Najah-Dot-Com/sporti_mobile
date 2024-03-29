import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/user_data.dart';
import 'package:sporti/feature/view/appwidget/dialog/gloable_dialog_widget.dart';
import 'package:sporti/feature/view/views/account_verfiy/account_verfiy_view.dart';
import 'package:sporti/feature/view/views/subscriptions/my_current_subscriptions/my_cureent_subscriptions_view.dart';
import 'package:sporti/feature/view/views/subscriptions/my_current_subscriptions/widget/current_subscribe_widget.dart';
import 'package:sporti/feature/viewmodel/auth_viewmodle.dart';
import 'package:sporti/util/app_color.dart';
import 'package:sporti/util/app_media.dart';
import 'package:sporti/util/app_strings.dart';
import 'package:sporti/util/sh_util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../feature/view/appwidget/custome_text_view.dart';
import '../network/api/feature/auth_feature.dart';
import '../network/utils/constance_netwoek.dart';
import 'app_dimen.dart';
import 'app_style.dart';
import 'constance.dart';
import 'localization/localization_service.dart';

String? urlPlacholder =
    "https://user-images.githubusercontent.com/194400/49531010-48dad180-f8b1-11e8-8d89-1e61320e1d82.png";
String? urlUserPlacholder =
    "https://jenalk.ahdtech.com/dev/assets/img/no-user.png";

// screenUtil(BuildContext context) {
//   ScreenUtil.init(
//       BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width,
//           maxHeight: MediaQuery.of(context).size.height),
//           context: context,
//       designSize: Size(392.72727272727275, 803.6363636363636),
//       orientation: Orientation.portrait);
// }

var safeAreaLight =
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
  systemNavigationBarColor: AppColor.white,
  statusBarColor: AppColor.white,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.dark,
));

var safeAreaDark =
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  systemNavigationBarColor: AppColor.white,
  statusBarColor: AppColor.transparent,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarIconBrightness: Brightness.dark,
));

var bottomNavDark =
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  systemNavigationBarColor: AppColor.primary,
  statusBarColor: AppColor.primary,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarIconBrightness: Brightness.light,
));

// var hideStatusBar =
//     SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
// var hideBottomBar =
//     SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
// var hideAllBar = SystemChrome.setEnabledSystemUIOverlays([]);

void portraitOrientation() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

passwordValid(String val) {
  if (val.length < 8) {
    return AppStrings.errorPasswordLength.tr; //key67
  } else {
    return null;
  }
}

phoneVaild(String value) {
  if (value.isEmpty) {
    return AppStrings.fillYourPhoneNumber.tr;
  } else if (value.length > 10 || value.length < 8) {
    return AppStrings.fillYourPhoneNumber.tr;
  }
  return null;
}

emailValid(String val) {
  if (!GetUtils.isEmail(val)) {
    return AppStrings.messageMatcherEmail.tr;
  } else {
    return;
  }
}

Widget simplePopup() => PopupMenuButton<int>(
      initialValue: 1,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text("First"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Second"),
        ),
      ],
    );

String getDeviceLang() {
  Locale myLocale = Localizations.localeOf(Get.context!);
  String languageCode = myLocale.languageCode;
  return languageCode;
}

// snackSuccess(String title, String body) {
//   Future.delayed(Duration(seconds: 0)).then((value) {
//     Get.snackbar("$title", "$body",
//         colorText: Colors.white,
//         margin: EdgeInsets.all(8),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Color(0xFF10C995));
//   });
// }

// snackError(String title, String body) {
//   Future.delayed(Duration(seconds: 0)).then((value) {
//     Get.snackbar("$title", "$body",
//         colorText: Colors.white,
//         margin: EdgeInsets.all(8),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Color(0xFFF2AE56).withAlpha(150));
//   });
// }

snackSuccess(String? title, String? body) {
  mainSnack(
      body: body ?? "",
      backgroundColor: const Color(0xFF10C995).withAlpha(150));
}

snackError(String? title, String? body) {
  mainSnack(
      body: body ?? "",
      backgroundColor: const Color(0xFFF2AE56).withAlpha(150));
}

snackConnection() {
  mainSnack(
      body: AppStrings.txtConnectionNote.tr,
      backgroundColor: const Color(0xFF000000).withAlpha(150));
}

mainSnack({String? title,  String? body, Color? backgroundColor}) {
  Future.delayed(const Duration(seconds: 0)).then((value) {
    try {
      Get.showSnackbar(
            GetSnackBar(
              backgroundColor: backgroundColor ?? const Color(0xFF303030),
              message: body != null && body.trim().isNotEmpty ? body:"error occurred",
              duration: const Duration(seconds: 2),
              borderRadius: 10,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
          );
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: backgroundColor ?? const Color(0xFF303030),
          message: "error occurred",
          duration: const Duration(seconds: 2),
          borderRadius: 10,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      );
    }
  });
}

showAnimatedDialog(dialog) {
  showGeneralDialog(
    barrierDismissible: false,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 700),
    context: Get.context!,
    pageBuilder: (context, anim1, anim2) {
      return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: dialog,
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(anim1),
        child: child,
      );
    },
  );
}

var urlProduct =
    "https://images.unsplash.com/photo-1613177794106-be20802b11d3?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2xvY2slMjBoYW5kc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80";

Widget imageNetwork({double? width, double? height, String? url, BoxFit? fit}) {
  try {
    return CachedNetworkImage(
      imageUrl: url ?? urlUserPlacholder!/*urlUserPlacholder!*/,
      errorWidget: (context, url, error) {
        return CachedNetworkImage(
            width: width , height: height,
            imageUrl: urlUserPlacholder!, fit: BoxFit.contain);
      },
      width: width ?? 74,
      height: height ?? 74,
      fit: BoxFit.cover,
      placeholder: (context, String? url) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppMedia
                  .loadingShimmer) ,
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                )),
          ),
        );
      },
    );
  } on Exception catch (e) {
    // TODO

    return CachedNetworkImage(
        width: width , height: height,
        imageUrl: urlUserPlacholder!, fit: BoxFit.contain);
  }
}

hideFocus(context) {
  FocusScopeNode currentFocus = FocusScope.of(context ?? Get.context!);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    currentFocus.focusedChild!.unfocus();
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

DateTime convertStringToDate(DateTime? date) {
  Logger().d("date befor ${date.toString()}");
  var stringDate = date.toString();
  Logger().d("date after $stringDate");
  return DateFormat("yyyy-MM-dd T hh:mm a").parse(stringDate);
}

compareToTime(TimeOfDay oneVal, TimeOfDay twoVal) {
  var format = DateFormat("HH:mm a");
  var one = format.parse(oneVal.format(Get.context!));
  var two = format.parse(twoVal.format(Get.context!));
  return one.isBefore(two);
}

double convertStringToDouble(String value) {
  return double.tryParse(value)!.toDouble();
}

updateLanguage(Locale locale) {
  Get.updateLocale(locale);
}

class CustomMaterialPageRoute extends MaterialPageRoute {
  @protected
  bool get hasScopedWillPopCallback {
    return false;
  }

  CustomMaterialPageRoute({
    @required WidgetBuilder? builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder!,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );
}

class DismissKeyboard extends StatelessWidget {
  final Widget? child;

  DismissKeyboard({this.child});

  @override
  Widget build(BuildContext context) {
    // screenUtil(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}

bool isArabicLang() {
  return (SharedPref.instance.getAppLanguageMain() ==
          LocalizationService.localeAr
      ? true
      : false);
  // return isRTL;
}

Future<DateTime?> dateBiker() async {
  Locale myLocale = Localizations.localeOf(Get.context!);
  var picker = await showDatePicker(
    context: Get.context!,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2030),
    locale: myLocale,
  );
  return picker;
}

Future<TimeOfDay?> timeBiker() async {
  var picker = await showTimePicker(
    context: Get.context!,
    helpText: AppStrings.txtReturnTime.tr,
    initialTime: TimeOfDay(
        hour: DateTime.now().hour,
        minute: DateTime.now().minute % 30 == 0 ? 0 : 30),
  );
  return picker;
}

String formatStringWithCurrency(var data /*, String currency*/) {
  try {
    var number = data.toString().replaceAll("\$", "").replaceAll(",", "");
    number =
        "\$ ${NumberFormat("#0.00", "en_US").format(double.parse(number))}";
    //var numbers = "${currency}${double.parse(number).toStringAsFixed(2)}";
    return number.toString();
  } catch (e) {
    print(e);
    return "0.00";
  }
}

Widget profileItem(ThemeData themeData,
    {bool? withBoxShadow = true,
    Color? color,
    required Function() onClick,
    required String title,
    required String leadingIcon,
    required String trailingIcon}) {
  return InkWell(
      onTap: onClick,
      child: withBoxShadow == true
          ? Container(
              width: double.infinity,
              height: AppSize.s50,
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
              margin: const EdgeInsets.only(bottom: AppSize.s12),
              decoration: BoxDecoration(
                  color: color ?? AppColor.white,
                  borderRadius: BorderRadius.circular(AppPadding.p8),
                 /* boxShadow: [AppShadow.boxShadow()!]*/),
              child: Row(
                children: [
                  SvgPicture.asset(leadingIcon ,color: AppColor.primary, width: AppSize.s20,),
                  const SizedBox(
                    width: AppSize.s20,
                  ),
                  Expanded(
                    child: CustomTextView(
                        txt: title, textStyle: themeData.textTheme.headline2),
                  ),
                  const SizedBox(
                    width: AppSize.s20,
                  ),
                  if (Get.locale == LocalizationService.localeEn &&
                      trailingIcon == AppMedia.arrowIos) ...[
                    const Icon(Icons.arrow_forward_ios),
                  ] else ...[
                    SvgPicture.asset(trailingIcon)
                  ]
                ],
              ),
            )
          : Container(
              width: double.infinity,
              height: AppSize.s50,
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
              margin: const EdgeInsets.only(bottom: AppSize.s12),
              decoration: BoxDecoration(
                color: color ?? AppColor.white,
                //borderRadius: BorderRadius.circular(AppPadding.p8),
                border: Border(
                  bottom: BorderSide(
                    color: AppColor.black,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(leadingIcon),
                  const SizedBox(
                    width: AppSize.s20,
                  ),
                  Expanded(
                    child: CustomTextView(
                        txt: title, textStyle: themeData.textTheme.headline2),
                  ),
                  const SizedBox(
                    width: AppSize.s20,
                  ),
                  if (Get.locale == LocalizationService.localeEn &&
                      trailingIcon == AppMedia.arrowIos) ...[
                    const Icon(Icons.arrow_forward_ios),
                  ] else ...[
                    SvgPicture.asset(trailingIcon)
                  ]
                ],
              ),
            ));
}

Future<bool> showIsVerifyDialog({required bool isNeedSubscriptions }) async {
  UserData? userData = SharedPref.instance.getUserData();
  Logger().w(userData.toJson());
  if (!userData.isVerify! && userData.username != Constance.guestUserNameKey) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      showAnimatedDialog(GlobalDialogWidget(
        title: AppStrings.txtAttentions.tr,
        subTitle: AppStrings.verifyHint.tr,
        isLoading: false,
        isTwoBtn: true,
        onCancelBtnClick: () => Get.back(),
        onOkBtnClick: () {
          Get.off(() => AccountVerifyView());
        },
      ));
    });
    return false;
  } else if (!userData.isVerify! &&
      userData.username == Constance.guestUserNameKey) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      showAnimatedDialog(GetBuilder<AuthViewModel>(
          init: AuthViewModel(),
          builder: (logic) {
            return GlobalDialogWidget(
              title: AppStrings.txtAttentions.tr,
              subTitle: AppStrings.loginHint.tr,
              isLoading: logic.isLoading,
              isTwoBtn: true,
              onCancelBtnClick: () => Get.back(),
              onOkBtnClick: () {
                logic.logoutUser(isFromGuest: true);
              },
            );
          }));
    });
    return false;
  } else if (isNeedSubscriptions && userData.isVerify! && (getSubscriptionsDate(userData))) {
    //todo this for end subscriptions
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      showAnimatedDialog(GlobalDialogWidget(
        title: AppStrings.txtAttentions.tr,
        subTitle: AppStrings.subscriptionsHint.tr,
        isLoading: false,
        isTwoBtn: true,
        onCancelBtnClick: () => Get.back(),
        onOkBtnClick: () {
          Get.off(const MyCurrentSubscriptionsView());
        },
      ));
    });
    return false;
  } else {
    return true;
  }
}

bool getSubscriptionsDate(UserData userData) {
  Logger().w(userData.toJson());
  // Logger().w(userData.planEndDate!.isBefore(DateTime.now()));
  // Logger().w(userData.planEndDate!.isAtSameMomentAs(DateTime.now()));
  Logger().w(DateTime.now().isAfter(userData.planEndDate!));
  Logger().w(userData.planEndDate!.isAtSameMomentAs(DateTime.now()));
  if (DateTime.now().isAfter(userData.planEndDate!)) {
    return true;
  } else if (userData.planEndDate!.isAtSameMomentAs(DateTime.now())) {
    return true;
  } else {
    return false;
  }
}
Future<void> openBrowser(String url) async {
  try {
    if (await canLaunch(url)) {
      await launch(url);
    }
  } catch (e) {
    Logger().d(e);
  }
}
loginAgain() {
  var userName = SharedPref.instance.getUserName();
  var password = SharedPref.instance.getPassword();

  if (userName.toString().isNotEmpty && password.toString().isNotEmpty) {
    Map<String, dynamic> map = {
      ConstanceNetwork.userNameKey: userName,
      ConstanceNetwork.passwordKey: password,
      ConstanceNetwork.fcmToken: SharedPref.instance.getFCMToken().toString(),
    };
    AuthFeature.getInstance.loginUser(map);
  }else {
    Map<String, dynamic> map = {
      ConstanceNetwork.socialIdKey: SharedPref.instance.getIdSocial(),
      ConstanceNetwork.fcmToken: SharedPref.instance.getFCMToken().toString(),
    };
    AuthFeature.getInstance.refreshLoginSocialMediaApi(map);
  }

  // var userNameSocial = SharedPref.instance.getUserNameSocial();
  // var emailSocial = SharedPref.instance.getEmailSocial();
  // var imageSocial = SharedPref.instance.getImageSocial();
  // var idSocial = SharedPref.instance.getIdSocial();
  // var socialType = SharedPref.instance.getSocialType();
  //
  // if (userNameSocial.toString().isNotEmpty && emailSocial.toString().isNotEmpty &&
  //     idSocial.toString().isNotEmpty && socialType.toString().isNotEmpty &&
  //     imageSocial.toString().isNotEmpty) {
  //   Map<String, dynamic> map = {
  //     ConstanceNetwork.socialTypeKey: socialType,
  //     ConstanceNetwork.socialIdKey: idSocial,
  //     ConstanceNetwork.imageKey: imageSocial,
  //     ConstanceNetwork.fullNameKey: userNameSocial,
  //     ConstanceNetwork.emailKey: emailSocial,
  //     ConstanceNetwork.fcmToken: SharedPref.instance.getFCMToken().toString(),
  //   };
  //   AuthFeature.getInstance.socialLoginUser(map);
  // }



}
Future pickImage(ImageSource imageSource, double maxWidth, double maxHeight) async {
  ImagePicker _picker = ImagePicker();
  XFile? pickImage = await _picker.pickImage(
      source: imageSource, maxWidth: maxWidth, maxHeight: maxHeight);
  if (pickImage != null) {
    File file = File(pickImage.path.toString());
    var uint8list = await file.readAsBytes();
    return uint8list;
  }
  throw "null file";
}

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sporti/util/app_shaerd_data.dart';

class FirebaseAuthModel {
  FirebaseAuthModel._();

  static final FirebaseAuthModel instance = FirebaseAuthModel._();

  factory FirebaseAuthModel() => instance;

  String? _verificationId ;

  String get verificationId => _verificationId.toString();

  set verificationId(String value) {
    _verificationId = value;
  } //this to enter mobile number
  Future verifyPhoneNumber(
    String userNumber,
    Function() onSuccess,
    Function() onFail,
  ) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: userNumber,
        verificationCompleted: (phonesAuthCredentials) async {
          if (Platform.isAndroid) {
            onSuccess();
          }
        },
        verificationFailed: (verificationFailed) async {
          var code = verificationFailed.code;
          Logger()
              .e("code : $code   fullCode : ${verificationFailed.toString()} ");
          if (code == "captcha-check-failed") {
            snackError("حدث عطل",
                " رمز استجابة reCAPTCHA غير صالح أو منتهي الصلاحية ");
          } else if (code == "invalid-phone-number") {
            snackError("حدث عطل", "رقم الهاتف به تنسيق غير صالح.");
          } else if (code == "missing-phone-number") {
            snackError("حدث عطل", "رقم الهاتف مفقود.");
          } else if (code == "quota-exceeded") {
            snackError("حدث عطل",
                "تم تجاوز حصة الرسائل القصيرة (SMS) الخاصة بالمشروع .");
          } else if (code == "user-disabled") {
            snackError(
                "حدث عطل", "تم تعطيل المستخدم المقابل لرقم الهاتف المحدد.");
          } else if (code == "operation-not-allowed") {
            snackError("حدث عطل",
                " لم تقم بتمكين الموفر في Firebase Console. انتقل إلى Firebase Console لمشروعك ، في قسم المصادقة وعلامة التبويب طريقة تسجيل الدخول وقم بتكوين الموفر. ");
          } else if (code == "too-many-requests") {
            snackError("حدث عطل",
                " لم تقم بتمكين الموفر في Firebase Console. انتقل إلى Firebase Console لمشروعك ، في قسم المصادقة وعلامة التبويب طريقة تسجيل الدخول وقم بتكوين الموفر. لقد حظرنا جميع الطلبات الواردة من هذا الجهاز بسبب نشاط غير عادي. حاول مرة أخرى في وقت لاحق.");
          } else {
            snackError("حدث عطل", verificationFailed.code.toString());
          }
          onFail();
        },
        codeSent: (veriId, resendingToken) async {
          if (Platform.isAndroid) {
            _verificationId = veriId;
            // verificationId(veriId);
            onSuccess();
          } else {
            _verificationId = veriId;
            // verificationId(veriId);
            onSuccess();
          }
        },
        codeAutoRetrievalTimeout: (veriId) async {
          _verificationId = veriId;
          onFail();
        });
  }

  //this for enter verification code
  Future sendCodeToFirebase(
      {required String? code,
      required Function() onSuccess,
      required Function() onFail}) async {
    // print("_verificationId : $_verificationId");
    Logger().d(!GetUtils.isNull(verificationId) && verificationId.isNotEmpty);
    if (!GetUtils.isNull(_verificationId) && verificationId.isNotEmpty) {
      var credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code!);
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((UserCredential value) async {
        //todo here if there code it's work
        onSuccess();
      }).onError((error, stackTrace) {
        snackError("", "يرجى التاكد من كود التحقق");
        onFail();
      });
    }
  }
}

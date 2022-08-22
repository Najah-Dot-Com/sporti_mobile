import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:huawei_iap/HmsIapResult.dart';
import 'package:huawei_iap/IapClient.dart';
import 'package:huawei_iap/model/InAppPurchaseData.dart';
import 'package:huawei_iap/model/IsEnvReadyResult.dart';
import 'package:huawei_iap/model/OwnedPurchasesReq.dart';
import 'package:huawei_iap/model/OwnedPurchasesResult.dart';
import 'package:huawei_iap/model/ProductInfo.dart';
import 'package:huawei_iap/model/ProductInfoReq.dart';
import 'package:huawei_iap/model/ProductInfoResult.dart';
import 'package:huawei_iap/model/PurchaseIntentReq.dart';
import 'package:huawei_iap/model/PurchaseResultInfo.dart';
import 'package:logger/logger.dart';

class HawaiiPurchasesApi {
  HawaiiPurchasesApi._();

  static final HawaiiPurchasesApi instance = HawaiiPurchasesApi._();

  factory HawaiiPurchasesApi() => instance;

  List<ProductInfo> available = [];
  List<InAppPurchaseData> purchased = [];

  Future init() async {
    if (!Platform.isAndroid && !Platform.isIOS && !kIsWeb) {
      IsEnvReadyResult envReadyResult = await IapClient.isEnvReady();
      Logger().wtf("hawaii_${envReadyResult.toJson()}");
      loadProducts();
      // ownedPurchases();
    }
    Logger().wtf("hawaii_${Platform.operatingSystem}");
  }

  loadProducts() async {
    try {
      ProductInfoResult result = await IapClient.obtainProductInfo(ProductInfoReq(
          priceType: 2,
          //Make sure that the product IDs are the same as those defined in AppGallery Connect.
          skuIds: ["sporti11_3", "sporti22_12"]));
      // setState(() {
      available.clear();
      if (result.productInfoList != null) {
        for (int i = 0; i < result.productInfoList!.length; i++) {
          available.add(result.productInfoList![i]);
        }
      }
      Logger().wtf(available.length);
      // });
    } on PlatformException catch (e) {
      if (e.code == HmsIapResults.ORDER_HWID_NOT_LOGIN.resultCode) {
        Logger().d(HmsIapResults.ORDER_HWID_NOT_LOGIN.resultMessage!);
      } else {
        Logger().d(e.toString());
      }
    }
  }

  Future<bool> buyProduct(String productID) async {
    if (!Platform.isAndroid && !Platform.isIOS && !kIsWeb) {
      try {
        PurchaseResultInfo result = await IapClient.createPurchaseIntent(
            PurchaseIntentReq(priceType: 1, productId: productID));
        if (result.returnCode == HmsIapResults.ORDER_STATE_SUCCESS.resultCode) {
          loadProducts();
          // ownedPurchases();
          return true;
        } else {
          if (result.errMsg != null) {
            Logger().d(result.errMsg!);
          } else {
            Logger().d(result.rawValue);
          }
          return false;
        }
      } on PlatformException catch (e) {
        if (e.code == HmsIapResults.ORDER_HWID_NOT_LOGIN.resultCode) {
          Logger().d(HmsIapResults.ORDER_HWID_NOT_LOGIN.resultMessage!);
        } else {
          Logger().d(e.toString());
        }
        return false;
      }
    }else{
      return false;
    }
  }

  ownedPurchases() async {
    try {
      OwnedPurchasesResult result =
          await IapClient.obtainOwnedPurchases(OwnedPurchasesReq(priceType: 1));
      // setState(() {
      purchased.clear();
      if (result.inAppPurchaseDataList != null) {
        for (int i = 0; i < result.inAppPurchaseDataList!.length; i++) {
          purchased.add(result.inAppPurchaseDataList![i]);
        }
      }
      // });
    } on PlatformException catch (e) {
      if (e.code == HmsIapResults.ORDER_HWID_NOT_LOGIN.resultCode) {
        Logger().d(HmsIapResults.ORDER_HWID_NOT_LOGIN.resultMessage!);
      } else {
        Logger().d(e.toString());
      }
    }
  }
}

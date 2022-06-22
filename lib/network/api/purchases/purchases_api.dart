import 'dart:io';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sporti/network/api/purchases/constance_purchases.dart';
import 'package:sporti/util/app_shaerd_data.dart';

class PurchasesApi {
  PurchasesApi._();

  static final PurchasesApi instance = PurchasesApi._();

  factory PurchasesApi() => instance;

  Future init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(Platform.isIOS
        ? ConstancePurchases.appIdIos
        : ConstancePurchases.appIdAndroid);
  }

  Future<List<Offering>> getOfferById(List<String> idsList) async {
    var offers = await getOffering(isAll: true);

    return offers
        .where((element) => idsList.contains(element.identifier))
        .toList();
  }

  Future<Package> getProductById(var idsList) async {
    try {
      Logger().w(idsList);
      var offers = await getOffering(isAll: true);
      if(offers.isNotEmpty) {
        return offers.last.availablePackages.firstWhere((element) =>
          element.product.identifier.toString() == idsList.toString());
      }else{
        throw "The device or user is not allowed to make the purchase.";
      }
    } on Exception catch (e) {
      // TODO
      print(e.toString());
      throw "PurchasesError(code=PurchaseNotAllowedError, underlyingErrorMessage=Billing is not available in this device. DebugMessage: Google Play In-app Billing API version is less than 3. ErrorCode: BILLING_UNAVAILABLE., message='The device or user is not allowed to make the purchase.')";
    }
  }

  Future<List<Offering>> getOffering({bool isAll = false}) async {
    try {
      var offerings = await Purchases.getOfferings();

      if (isAll) {
        Logger().w(offerings.all.values.toList());
        return offerings.all.values.toList();
      } else {
        final current = offerings.current;
        return current == null ? [] : [current];
      }
    }on PlatformException catch (err) {
      snackError("", "${err.message}");
      return [];
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<bool> purchasesSubscriptions(Package package, {String? androidId}) async {
    try {
        await Purchases.purchasePackage(package);
      return true;
    } catch (e) {
      snackError("", "$e");
      return false;
    }
  }
}

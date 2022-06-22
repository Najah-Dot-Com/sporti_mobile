import 'dart:io';

class ConstancePurchases {
  static const appIdAndroid = "goog_cbtHNFKuXXzqfUhsIxrSCZJshXi";
  static const appIdIos = "appl_NIkvfTyHPRuiklTGRrduHbpfvPc";
  static String basicId = (Platform.isIOS ? "sporti111":"sporti11");
  static const unLimitedId = "sporti22";
  static const freeType = "Free";
  static const basicType = "Basic";
  static const unLimitedType = "UnLimited";
  static const unlimited = "Unlimited";
  static const int oneMonth = 31;
  static const int threeMonth = 92;
  static const int unLimitedMonth = ((30 * 12) + 5) /** 10*/;

}

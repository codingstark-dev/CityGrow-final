import 'dart:async';

import 'package:digitalproductstore/config/ps_constants.dart';
import 'package:digitalproductstore/viewobject/common/ps_value_holder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digitalproductstore/utils/utils.dart';

class PsSharedPreferences {
  PsSharedPreferences._() {
    Utils.psPrint('init PsSharePerference $hashCode');
    futureShared = SharedPreferences.getInstance();
    futureShared.then((SharedPreferences shared) {
      this.shared = shared;
      //loadUserId('Admin');
      loadValueHolder();
    });
  }

  Future<SharedPreferences> futureShared;
  SharedPreferences shared;

// Singleton instance
  static final PsSharedPreferences _singleton = PsSharedPreferences._();

  // Singleton accessor
  static PsSharedPreferences get instance => _singleton;

  // PsSharedPreferences() {
  //   Utils.psPrint('init PsSharePerference');
  //   futureShared = SharedPreferences.getInstance();
  //   futureShared.then((shared) {
  //     this.shared = shared;
  //     loadUserId('Admin');
  //   });
  // }
  // final StreamController<String> _userController = StreamController<String>();
  // Stream<String> get userId => _userController.stream;

  // Future<dynamic> loadUserId(String userId) async {
  //   await shared.setString('USERID', userId);
  //   _userController.add(shared.getString('USERID'));
  // }

  final StreamController<PsValueHolder> _valueController =
      StreamController<PsValueHolder>();
  Stream<PsValueHolder> get psValueHolder => _valueController.stream;

  void loadValueHolder() {
    final String _loginUserId = shared.getString(VALUE_HOLDER__USER_ID);
    final String _userIdToVerify =
        shared.getString(VALUE_HOLDER__USER_ID_TO_VERIFY);
    final String _userNameToVerify =
        shared.getString(VALUE_HOLDER__USER_NAME_TO_VERIFY);
    final String _userEmailToVerify =
        shared.getString(VALUE_HOLDER__USER_EMAIL_TO_VERIFY);
    final String _userPasswordToVerify =
        shared.getString(VALUE_HOLDER__USER_PASSWORD_TO_VERIFY);
    final String _notiToken = shared.getString(VALUE_HOLDER__NOTI_TOKEN);
    final bool _notiSetting = shared.getBool(VALUE_HOLDER__NOTI_SETTING);
    final String _overAllTaxLabel =
        shared.getString(VALUE_HOLDER__OVERALL_TAX_LABEL);
    final String _overAllTaxValue =
        shared.getString(VALUE_HOLDER__OVERALL_TAX_VALUE);
    final String _shippingTaxLabel =
        shared.getString(VALUE_HOLDER__SHIPPING_TAX_LABEL);
    final String _shippingTaxValue =
        shared.getString(VALUE_HOLDER__SHIPPING_TAX_VALUE);
    final String _appInfoVersionNo = shared.getString(APPINFO_PREF_VERSION_NO);
    final bool _appInfoForceUpdate = shared.getBool(APPINFO_PREF_FORCE_UPDATE);
    final String _appInfoForceUpdateTitle =
        shared.getString(APPINFO_FORCE_UPDATE_TITLE);
    final String _appInfoForceUpdateMsg =
        shared.getString(APPINFO_FORCE_UPDATE_MSG);
    final String _startDate = shared.getString(VALUE_HOLDER__START_DATE);
    final String _endDate = shared.getString(VALUE_HOLDER__END_DATE);

    final String _paypalEnabled =
        shared.getString(VALUE_HOLDER__PAYPAL_ENABLED);
    final String _stripeEnabled =
        shared.getString(VALUE_HOLDER__STRIPE_ENABLED);
    final String _codEnabled = shared.getString(VALUE_HOLDER__COD_ENABLED);
    final String _bankEnabled =
        shared.getString(VALUE_HOLDER__BANK_TRANSFER_ENABLE);
    final String _publishKey = shared.getString(VALUE_HOLDER__PUBLISH_KEY);
    _valueController.add(PsValueHolder(
        loginUserId: _loginUserId,
        userIdToVerify: _userIdToVerify,
        userNameToVerify: _userNameToVerify,
        userEmailToVerify: _userEmailToVerify,
        userPasswordToVerify: _userPasswordToVerify,
        deviceToken: _notiToken,
        notiSetting: _notiSetting,
        overAllTaxLabel: _overAllTaxLabel,
        overAllTaxValue: _overAllTaxValue,
        shippingTaxLabel: _shippingTaxLabel,
        shippingTaxValue: _shippingTaxValue,
        appInfoVersionNo: _appInfoVersionNo,
        appInfoForceUpdate: _appInfoForceUpdate,
        appInfoForceUpdateTitle: _appInfoForceUpdateTitle,
        appInfoForceUpdateMsg: _appInfoForceUpdateMsg,
        startDate: _startDate,
        endDate: _endDate,
        paypalEnabled: _paypalEnabled,
        stripeEnabled: _stripeEnabled,
        codEnabled: _codEnabled,
        bankEnabled: _bankEnabled,
        publishKey: _publishKey));
  }

  Future<dynamic> replaceLoginUserId(String loginUserId) async {
    await shared.setString(VALUE_HOLDER__USER_ID, loginUserId);

    loadValueHolder();
  }

  Future<dynamic> replaceNotiToken(String notiToken) async {
    await shared.setString(VALUE_HOLDER__NOTI_TOKEN, notiToken);

    loadValueHolder();
  }

  Future<dynamic> replaceNotiSetting(bool notiSetting) async {
    await shared.setBool(VALUE_HOLDER__NOTI_SETTING, notiSetting);

    loadValueHolder();
  }

  Future<dynamic> replaceDate(String startDate, String endDate) async {
    await shared.setString(VALUE_HOLDER__START_DATE, startDate);
    await shared.setString(VALUE_HOLDER__END_DATE, endDate);

    loadValueHolder();
  }

  Future<dynamic> replaceVerifyUserData(
      String userIdToVerify,
      String userNameToVerify,
      String userEmailToVerify,
      String userPasswordToVerify) async {
    await shared.setString(VALUE_HOLDER__USER_ID_TO_VERIFY, userIdToVerify);
    await shared.setString(VALUE_HOLDER__USER_NAME_TO_VERIFY, userNameToVerify);
    await shared.setString(
        VALUE_HOLDER__USER_EMAIL_TO_VERIFY, userEmailToVerify);
    await shared.setString(
        VALUE_HOLDER__USER_PASSWORD_TO_VERIFY, userPasswordToVerify);

    loadValueHolder();
  }

  Future<dynamic> replaceVersionForceUpdateData(bool appInfoForceUpdate) async {
    await shared.setBool(APPINFO_PREF_FORCE_UPDATE, appInfoForceUpdate);

    loadValueHolder();
  }

  Future<dynamic> replaceAppInfoData(
      String appInfoVersionNo,
      bool appInfoForceUpdate,
      String appInfoForceUpdateTitle,
      String appInfoForceUpdateMsg) async {
    await shared.setString(APPINFO_PREF_VERSION_NO, appInfoVersionNo);
    await shared.setBool(APPINFO_PREF_FORCE_UPDATE, appInfoForceUpdate);
    await shared.setString(APPINFO_FORCE_UPDATE_TITLE, appInfoForceUpdateTitle);
    await shared.setString(APPINFO_FORCE_UPDATE_MSG, appInfoForceUpdateMsg);

    loadValueHolder();
  }

  Future<dynamic> replaceTransactionValueHolderData(
      String overAllTaxLabel,
      String overAllTaxValue,
      String shippingTaxLabel,
      String shippingTaxValue) async {
    await shared.setString(VALUE_HOLDER__OVERALL_TAX_LABEL, overAllTaxLabel);
    await shared.setString(VALUE_HOLDER__OVERALL_TAX_VALUE, overAllTaxValue);
    await shared.setString(VALUE_HOLDER__SHIPPING_TAX_LABEL, shippingTaxLabel);
    await shared.setString(VALUE_HOLDER__SHIPPING_TAX_VALUE, shippingTaxValue);

    loadValueHolder();
  }

  Future<dynamic> replaceCheckoutEnable(String paypalEnabled,
      String stripeEnabled, String codEnabled, String bankEnabled) async {
    await shared.setString(VALUE_HOLDER__PAYPAL_ENABLED, paypalEnabled);
    await shared.setString(VALUE_HOLDER__STRIPE_ENABLED, stripeEnabled);
    await shared.setString(VALUE_HOLDER__COD_ENABLED, codEnabled);
    await shared.setString(VALUE_HOLDER__BANK_TRANSFER_ENABLE, bankEnabled);

    loadValueHolder();
  }

  Future<dynamic> replacePublishKey(String pubKey) async {
    await shared.setString(VALUE_HOLDER__PUBLISH_KEY, pubKey);

    loadValueHolder();
  }
}

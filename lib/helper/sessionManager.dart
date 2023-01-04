import 'package:egrocer_seller/helper/utils/routeGenerator.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/constant.dart';

class SessionManager extends ChangeNotifier {
  static String preferenceName = "egrocerappPref";
  static String isUserLogin = "isuserlogin";
  static String isDarkTheme = "isDarkTheme";
  static String appThemeName = "appThemeName";
  static String keyLangCode = "selectedLanguageCode";
  static String keyAuthUid = "keyAuthUid";
  static String keyUserName = "userName";
  static String keyUserImage = "image";
  static String keyPhone = "phone";
  static String keyEmail = "email";
  static String keyCountryCode = "countryCode";
  static String keyUserStatus = "userStatus";
  static String keyFCMToken = "keyFCMToken";
  static String keyAppToken = "keyAppToken";
  static String keyIsGrid = "isGrid";
  static String keyLatitude = "keyLatitude";
  static String keyLongitude = "keyLongitude";
  static String keyAddress = "keyAddress";
  static String keyBalance = "keyBalance";
  static String keyUserType = "keyUserType";

  static String keyCurrency = "currency";

  late SharedPreferences prefs;

  SessionManager({required this.prefs});

  String getData(String id) {
    return prefs.getString(id) ?? "";
  }

  Locale getCurrLang() {
    String langcode = prefs.getString(keyLangCode) ?? Constant.defaultLangCode;

    return Locale(langcode);
  }

  setCurrLang(String languageCode, BuildContext context) {
    prefs.setString(keyLangCode, languageCode);
    notifyListeners();
  }

  void setData(String id, String val, bool isRefresh) {
    prefs.setString(id, val);
    if (isRefresh) {
      notifyListeners();
    }
  }

  void setUserData(
      {required String name,
      required String email,
      required String profile,
      required String mobile,
      required int status,
      required String token,
      required String balance}) {
    prefs.setBool(isUserLogin, true);
    prefs.setString(keyUserName, name);
    prefs.setString(keyEmail, email);
    prefs.setString(keyUserImage, profile);
    prefs.setString(keyPhone, mobile);
    prefs.setInt(keyUserStatus, status);
    prefs.setString(keyAppToken, token);
    prefs.setString(
      keyBalance,
      balance.toString(),
    );
  }

  void setDoubleData(String key, double value) {
    prefs.setDouble(key, value);
    notifyListeners();
  }

  double getDoubleData(String key) {
    return prefs.getDouble(key) ?? 0.0;
  }

  bool getBoolData(String key) {
    return prefs.getBool(key) ?? false;
  }

  void setBoolData(String key, bool value, bool isRefresh) {
    prefs.setBool(key, value);
    if (isRefresh) notifyListeners();
  }

  int getIntData(String key) {
    return prefs.getInt(key) ?? 0;
  }

  void setIntData(String key, int value) {
    prefs.setInt(key, value);
    notifyListeners();
  }

  bool isUserLoggedIn() {
    if (prefs.getBool(isUserLogin) == null) {
      return false;
    } else {
      return prefs.getBool(isUserLogin) ?? false;
    }
  }

  void logoutUser(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          StringsRes.lblLogoutTitle,
          softWrap: true,
        ),
        content: Text(
          StringsRes.lblLogoutMessage,
          softWrap: true,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              StringsRes.lblCancel,
              softWrap: true,
            ),
          ),
          TextButton(
            onPressed: () {
              prefs.clear();
              setBoolData(isUserLogin, false, false);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  accountTypeScreen, (Route<dynamic> route) => false);
            },
            child: Text(
              StringsRes.lblOk,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  void deleteUserAccount(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          StringsRes.lblDeleteUserTitle,
          softWrap: true,
        ),
        content: Text(
          StringsRes.lblDeleteUserMessage,
          softWrap: true,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              StringsRes.lblCancel,
              softWrap: true,
            ),
          ),
          TextButton(
            onPressed: () async {
              // await getDeleteAccountApi(context: context)
              //     .then((response) async {
              //   if (response[ApiAndParams.status] == 1) {
              //     setBoolData(introSlider, true, false);
              //     setBoolData(isUserLogin, false, false);
              //     Navigator.of(context).pushNamedAndRemoveUntil(
              //         loginScreen, (Route<dynamic> route) => false);
              //   } else {
              //     GeneralMethods.showSnackBarMsg(
              //         context, response[ApiAndParams.message],
              //         snackBarSecond: 2);
              //   }
              // });
            },
            child: Text(
              StringsRes.lblOk,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

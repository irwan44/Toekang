import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/sessionManager.dart';
import 'package:egrocer_seller/helper/utils/routeGenerator.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'constant.dart';

class GeneralMethods {
  static String formatDate(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  }

  static Future<bool> checkInternet() async {
    bool check = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      check = true;
    }
    return check;
  }

  static NetworkStatus getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi
        ? NetworkStatus.Online
        : NetworkStatus.Offline;
  }

  static showSnackBarMsg(BuildContext? context, String msg,
      {int snackBarSecond = 2, bool requiredAction = false}) {
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        action: SnackBarAction(
            label: requiredAction ? "Login" : "",
            onPressed: () {
              if (requiredAction) {
                Navigator.pushNamed(context, loginScreen);
              }
            }),
        content: Text(
          msg,
          softWrap: true,
        ),
        duration: Duration(seconds: snackBarSecond),
      ),
    );
  }

  static List<Locale> langList() {
    return Constant.supportedLanguages
        .map(
          (languageCode) => GeneralMethods.getLocaleFromLangCode(languageCode),
        )
        .toList();
  }

  static Locale getLocaleFromLangCode(String languageCode) {
    List<String> result = languageCode.split("-");
    return result.length == 1
        ? Locale(result.first)
        : Locale(result.first, result.last);
  }

  static String setFirstLetterUppercase(String value) {
    if (value.isNotEmpty) value = value.replaceAll("_", ' ');
    return value.toTitleCase();
  }

  static Future sendApiRequest(
      {required String apiName,
      required Map<String, dynamic> params,
      required bool isPost}) async {
    try {
      String token = Constant.session.getData(SessionManager.keyAppToken);

      String baseUrl =
          "${Constant.hostUrl}api/${Constant.session.getData(SessionManager.keyUserType) == "seller" ? "seller" : "delivery_boy"}/";

      Map<String, String> headersData = {
        "accept": "application/json",
      };

      if (token.trim().isNotEmpty) {
        headersData["Authorization"] = "Bearer $token";
      }

      headersData["x-access-key"] = "903361";

      String mainUrl =
          apiName.contains("http") ? apiName : "${baseUrl}$apiName";

      http.Response response;
      if (isPost) {
        response = await http.post(Uri.parse(mainUrl),
            body: params.isNotEmpty ? params : null, headers: headersData);
      } else {
        mainUrl = await Constant.getGetMethodUrlWithParams(
            apiName.contains("http") ? apiName : "${baseUrl}$apiName", params);

        response = await http.get(Uri.parse(mainUrl), headers: headersData);
      }

      if (response.statusCode == 200) {
        if (response.body == "null") {
          return null;
        }
        return response.body;
      } else if (response.statusCode == 401) {
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future sendApiMultiPartRequest(
      {required String apiName,
      required Map<String, String> params,
      required List<String> fileParamsNames,
      required List<String> fileParamsFilesPath,
      required BuildContext context}) async {
    Map<String, String> headersData = {};

    String token = Constant.session.getData(SessionManager.keyFCMToken);
    String baseUrl =
        "${Constant.hostUrl}api/${Constant.session.getData(SessionManager.keyUserType) == "seller" ? "seller" : "delivery_boy"}/";

    String mainUrl = apiName.contains("http") ? apiName : "${baseUrl}$apiName";

    headersData["Authorization"] = "Bearer $token";
    headersData["x-access-key"] = "903361";
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(mainUrl),
    );

    request.fields.addAll(params);

    if (fileParamsNames.isNotEmpty) {
      // for (int i = 0; i <= fileParamsNames.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
        fileParamsNames[0].toString(),
        fileParamsFilesPath[0].toString(),
      ));
      // }
    }
    request.headers.addAll(headersData);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      GeneralMethods.showSnackBarMsg(
          context, response.reasonPhrase ?? StringsRes.lblSomethingWentWrong);
      return null;
    }
  }

  static String? validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }

  static emailValidation(String val, String msg) {
    return validateEmail(
      val.trim(),
    );
  }

  static emptyValidation(String val, String msg) {
    if (val.trim().isEmpty) {
      return msg;
    }
    return null;
  }

  static phoneValidation(String value, String msg) {
    String pattern = r'[0-9]';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty || !regExp.hasMatch(value)) {
      return msg;
    }
    return null;
  }

  static String getCurrencyFormat(double amount) {
    return NumberFormat.currency(
            symbol: Constant.currency,
            decimalDigits: int.parse(Constant.currencyDecimalPoint),
            name: Constant.currencyCode)
        .format(amount);
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map(
        (str) => str.toCapitalized(),
      )
      .join(' ');
}

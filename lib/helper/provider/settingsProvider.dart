import 'package:egrocer_seller/helper/repositories/settingsApi.dart';
import 'package:egrocer_seller/helper/utils/apiAndParams.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/models/appSettings.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  Future getSettingsApiProvider(
      Map<String, String> params, BuildContext context) async {
    try {
      Map<String, dynamic> settingsApiResponse =
          await getAppSettingsRepository(params: params);

      if (settingsApiResponse[ApiAndParams.status] == 1) {
        AppSettings appSettings = AppSettings.fromJson(settingsApiResponse);
        Constant.currency = appSettings.data.currency ?? "";
        Constant.currencyCode = appSettings.data.currencyCode ?? "";
        Constant.currencyCode = appSettings.data.currencyCode ?? "";
        Constant.privacyPolicy = appSettings.data.privacyPolicySeller ?? "";
        Constant.termsConditions = appSettings.data.termsConditionsSeller ?? "";
        Constant.currencyDecimalPoint = appSettings.data.decimalPoint ?? "";
        Constant.appMode = appSettings.data.appModeSeller ?? "";
        Constant.allPermissions = appSettings.data.allPermissions ?? [];
        return true;
      } else {
        GeneralMethods.showSnackBarMsg(
            context, settingsApiResponse[ApiAndParams.message]);
        return false;
      }
    } catch (e) {
      GeneralMethods.showSnackBarMsg(
        context,
        e.toString(),
      );
      return false;
    }
  }
}

import 'dart:convert';

import 'package:egrocer_seller/helper/utils/apiAndParams.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';

Future<Map<String, dynamic>> getAppSettingsRepository(
    {required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(
      apiName: ApiAndParams.apiAppSettings, params: params, isPost: false);

  return json.decode(response);
}

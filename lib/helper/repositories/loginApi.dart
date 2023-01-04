import 'dart:convert';

import 'package:egrocer_seller/helper/utils/apiAndParams.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';

Future<Map<String, dynamic>> getSellerLoginRepository(
    {required Map<String, dynamic> params}) async {
  var response = await GeneralMethods.sendApiRequest(
      apiName: ApiAndParams.apiLogin, params: params, isPost: true);

  return json.decode(response);
}

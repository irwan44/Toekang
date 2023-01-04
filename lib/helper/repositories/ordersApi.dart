import 'dart:convert';

import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:flutter/material.dart';

import '../utils/apiAndParams.dart';

Future<Map<String, dynamic>> getOrdersRepository(
    {required Map<String, String> params,
    required BuildContext context}) async {
  try {
    final result = await GeneralMethods.sendApiRequest(
        apiName: ApiAndParams.apiOrdersHistory, params: params, isPost: false);

    return Map.from(
      jsonDecode(result),
    );
  } catch (e) {
    //
    return {};
  }
}

Future<Map<String, dynamic>> getOrderStatusesRepository(
    {required BuildContext context}) async {
  try {
    final result = await GeneralMethods.sendApiRequest(
        apiName: ApiAndParams.apiOrderStatuses, params: {}, isPost: false);

    return Map.from(
      jsonDecode(result),
    );
  } catch (e) {
    //
    return {};
  }
}

Future<Map<String, dynamic>> updateOrderStatusRepository(
    {required Map<String, String> params}) async {
  try {
    final response = await GeneralMethods.sendApiRequest(
        apiName: ApiAndParams.apiUpdateOrderStatus,
        params: params,
        isPost: true);

    if (response == null) {
      throw Exception("Something went wrong");
    }

    return json.decode(response);
  } catch (e) {
    throw e;
  }
}

Future<Map<String, dynamic>> updateOrdersDeliveryBoyRepository(
    {required Map<String, String> params}) async {
  try {
    final response = await GeneralMethods.sendApiRequest(
        apiName: ApiAndParams.apiUpdateOrderDeliveryBoy,
        params: params,
        isPost: true);

    if (response == null) {
      throw Exception("Something went wrong");
    }

    return json.decode(response);
  } catch (e) {
    throw e;
  }
}

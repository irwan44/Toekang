import 'package:egrocer_seller/helper/repositories/orderDetailApi.dart';
import 'package:egrocer_seller/helper/utils/apiAndParams.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/models/orderDetail.dart';
import 'package:flutter/material.dart';

enum OrderDetailState {
  initial,
  loading,
  loaded,
  error,
}

class OrderDetailProvider extends ChangeNotifier {
  String message = '';
  OrderDetailState orderDetailState = OrderDetailState.initial;
  late OrderDetail orderDetail;

  getOrderDetail({
    required String orderId,
    required BuildContext context,
  }) async {
    orderDetailState = OrderDetailState.loading;
    notifyListeners();

    try {
      Map<String, String> params = {};
      params[ApiAndParams.orderId] = orderId;

      Map<String, dynamic> getData =
          (await getOrderDetailRepository(params: params));
      if (getData[ApiAndParams.status] == 1) {
        orderDetail = OrderDetail.fromJson(getData);

        orderDetailState = OrderDetailState.loaded;
        notifyListeners();
      } else {
        orderDetailState = OrderDetailState.error;
        notifyListeners();
        GeneralMethods.showSnackBarMsg(context, getData[ApiAndParams.message]);
      }
    } catch (e) {
      message = e.toString();
      orderDetailState = OrderDetailState.error;
      GeneralMethods.showSnackBarMsg(context, message);
      notifyListeners();
    }
  }
}

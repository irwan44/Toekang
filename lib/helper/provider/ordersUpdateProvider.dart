import 'package:egrocer_seller/helper/repositories/ordersApi.dart';
import 'package:egrocer_seller/helper/utils/apiAndParams.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/models/orderStatuses.dart';
import 'package:flutter/material.dart';

enum OrderUpdateStatusState {
  initial,
  loading,
  loaded,
  error,
}

class OrderUpdateProvider extends ChangeNotifier {
  OrderUpdateStatusState ordersStatusState = OrderUpdateStatusState.initial;
  String message = '';
  late OrderStatuses orderStatuses;
  List<OrderStatusesData> orderStatusesList = [];
  int selectedOrderStatus = 0;

  Future getOrdersStatuses({
    required BuildContext context,
  }) async {
    try {
      ordersStatusState = OrderUpdateStatusState.loading;
      notifyListeners();

      Map<String, dynamic> getStatusData =
          (await getOrderStatusesRepository(context: context));

      if (getStatusData[ApiAndParams.status] == 1) {
        orderStatuses = OrderStatuses.fromJson(getStatusData);
        orderStatusesList = orderStatuses.data ?? [];
        ordersStatusState = OrderUpdateStatusState.loaded;
        notifyListeners();
      } else {
        ordersStatusState = OrderUpdateStatusState.loaded;
        GeneralMethods.showSnackBarMsg(
            context, getStatusData[ApiAndParams.message]);
        notifyListeners();
      }
    } catch (e) {
      message = e.toString();
      ordersStatusState = OrderUpdateStatusState.error;
      GeneralMethods.showSnackBarMsg(context, message);
      notifyListeners();
    }
  }

  Future updateOrdersStatus({
    required Map<String, String> params,
    required BuildContext context,
  }) async {
    try {
      ordersStatusState = OrderUpdateStatusState.loading;
      notifyListeners();

      Map<String, dynamic> getUpdatedOrderData =
          await updateOrderStatusRepository(params: params);

      if (getUpdatedOrderData[ApiAndParams.status] == 1) {
        ordersStatusState = OrderUpdateStatusState.loaded;
        notifyListeners();
      } else {
        ordersStatusState = OrderUpdateStatusState.error;
        GeneralMethods.showSnackBarMsg(
            context, getUpdatedOrderData[ApiAndParams.message]);
        notifyListeners();
      }
    } catch (e) {
      message = e.toString();
      ordersStatusState = OrderUpdateStatusState.error;
      GeneralMethods.showSnackBarMsg(context, message);
      notifyListeners();
    }
  }

  setSelectedStatus(int index) {
    selectedOrderStatus = index;
    notifyListeners();
  }
}

import 'package:egrocer_seller/helper/repositories/deliveryBoysApi.dart';
import 'package:egrocer_seller/helper/repositories/ordersApi.dart';
import 'package:egrocer_seller/helper/utils/apiAndParams.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/models/deliveryBoys.dart';
import 'package:flutter/material.dart';

enum DeliveryBoysState {
  initial,
  loading,
  loaded,
  loadingMore,
  deliveryBoyUpdating,
  deliveryBoyUpdated,
  deliveryBoyUpdateError,
  error,
}

class DeliveryBoysProvider extends ChangeNotifier {
  DeliveryBoysState deliveryBoysState = DeliveryBoysState.initial;
  String message = '';
  late DeliveryBoys deliveryBoys;
  List<DeliveryBoysData> deliveryBoysList = [];
  bool hasMoreData = false;
  int totalData = 0;
  int offset = 0;
  int selectedDeliveryBoy = 0;

  getDeliveryBoys({
    required int selectedDeliveryBoyIndex,
    required BuildContext context,
  }) async {
    if (offset == 0) {
      deliveryBoysState = DeliveryBoysState.loading;
      notifyListeners();
    } else {
      deliveryBoysState = DeliveryBoysState.loadingMore;
      notifyListeners();
    }

    try {
      Map<String, String> params = {};
      selectedDeliveryBoy = selectedDeliveryBoyIndex;
      params[ApiAndParams.limit] =
          Constant.defaultDataLoadLimitAtOnce.toString();
      params[ApiAndParams.offset] = offset.toString();

      Map<String, dynamic> getData =
          (await getDeliveryBoysRepository(params: params));

      if (getData[ApiAndParams.status] == 1) {
        deliveryBoys = DeliveryBoys.fromJson(getData);
        totalData = getData[ApiAndParams.total];
        List<DeliveryBoysData> tempDeliveryBoys = deliveryBoys.data ?? [];

        deliveryBoysList.addAll(tempDeliveryBoys);
      }

      hasMoreData = totalData > deliveryBoysList.length;
      if (hasMoreData) {
        offset += Constant.defaultDataLoadLimitAtOnce;
      }

      deliveryBoysState = DeliveryBoysState.loaded;
      notifyListeners();
    } catch (e) {
      message = e.toString();
      deliveryBoysState = DeliveryBoysState.error;
      GeneralMethods.showSnackBarMsg(context, message);
      notifyListeners();
    }
  }

  Future updateOrdersDeliveryBoy({
    required Map<String, String> params,
    required BuildContext context,
  }) async {
    try {
      deliveryBoysState = DeliveryBoysState.deliveryBoyUpdating;
      notifyListeners();

      Map<String, dynamic> getUpdatedOrderData =
          await updateOrdersDeliveryBoyRepository(params: params);

      if (getUpdatedOrderData[ApiAndParams.status] == 1) {
        deliveryBoysState = DeliveryBoysState.deliveryBoyUpdated;
        notifyListeners();
      } else {
        deliveryBoysState = DeliveryBoysState.deliveryBoyUpdateError;
        GeneralMethods.showSnackBarMsg(
            context, getUpdatedOrderData[ApiAndParams.message]);
        notifyListeners();
      }
    } catch (e) {
      message = e.toString();
      deliveryBoysState = DeliveryBoysState.deliveryBoyUpdateError;
      GeneralMethods.showSnackBarMsg(context, message);
      notifyListeners();
    }
  }

  Future setSelectedIndex(int index) async {
    selectedDeliveryBoy = index;
    notifyListeners();
  }
}

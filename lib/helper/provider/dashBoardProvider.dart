import 'package:egrocer_seller/helper/repositories/dashBoardApi.dart';
import 'package:egrocer_seller/helper/sessionManager.dart';
import 'package:egrocer_seller/helper/utils/apiAndParams.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/models/deliveryBoyDashBoard.dart';
import 'package:egrocer_seller/models/sellerDashBoard.dart';
import 'package:flutter/material.dart';

enum DashboardState { initial, loading, loaded, error }

class DashboardProvider extends ChangeNotifier {
  DashboardState dashboardState = DashboardState.initial;
  var dashBoard;
  double maxSaleLimit = 0.0;

  Future dashboardApiProvider(
      Map<String, String> params, BuildContext context) async {
    try {
      dashboardState = DashboardState.loading;
      notifyListeners();

      Map<String, dynamic> dashboardApiResponse =
          await getDashboardRepository(params: params);

      if (dashboardApiResponse[ApiAndParams.status] == 1) {
        if (Constant.session.getData(SessionManager.keyUserType) == "seller") {
          dashBoard = SellerDashBoard.fromJson(dashboardApiResponse);
          for (int i = 0; i < dashBoard.data!.weeklySales!.length; i++) {
            WeeklySales weeklySale = dashBoard.data!.weeklySales![i];
            if (i == 0) {
              maxSaleLimit = weeklySale.totalSale!;
            } else if (maxSaleLimit.ceil() > weeklySale.totalSale!.ceil()) {
              maxSaleLimit = weeklySale.totalSale!;
            }
          }
        } else {
          dashBoard = DeliveryBoyDashBoard.fromJson(dashboardApiResponse);
        }

        dashboardState = DashboardState.loaded;
        notifyListeners();
        return dashBoard;
      } else {
        GeneralMethods.showSnackBarMsg(
            context, dashboardApiResponse[ApiAndParams.message]);
        dashboardState = DashboardState.error;
        notifyListeners();
      }
    } catch (e) {
      GeneralMethods.showSnackBarMsg(
        context,
        e.toString(),
      );
      dashboardState = DashboardState.error;
      notifyListeners();
    }
  }
}

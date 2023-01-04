import 'package:egrocer_seller/helper/repositories/loginApi.dart';
import 'package:egrocer_seller/helper/sessionManager.dart';
import 'package:egrocer_seller/helper/utils/apiAndParams.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/models/deliveryBoyLogin.dart';
import 'package:egrocer_seller/models/sellerLogin.dart';
import 'package:flutter/material.dart';

enum LoginState { initial, loading, loaded, error }

class UserProfileProvider extends ChangeNotifier {
  LoginState loginState = LoginState.initial;
  bool hidePassword = true;

  Future<Object?> loginApiProvider(
      Map<String, String> params, BuildContext context) async {
    try {
      loginState = LoginState.loading;
      notifyListeners();

      Map<String, dynamic> loginApiResponse =
          await getSellerLoginRepository(params: params);

      if (loginApiResponse[ApiAndParams.status] == 1) {
        loginState = LoginState.loaded;
        notifyListeners();
        if (Constant.session.getData(SessionManager.keyUserType) == "seller") {
          return SellerLogin.fromJson(loginApiResponse);
        } else {
          return DeliveryBoyLogin.fromJson(loginApiResponse);
        }
      } else {
        GeneralMethods.showSnackBarMsg(
            context, loginApiResponse[ApiAndParams.message]);
        loginState = LoginState.error;
        notifyListeners();
        return null;
      }
    } catch (e) {
      GeneralMethods.showSnackBarMsg(
        context,
        e.toString(),
      );
      loginState = LoginState.error;
      notifyListeners();
      return null;
    }
  }

  showHidePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }
}

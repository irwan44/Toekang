import 'package:egrocer_seller/helper/provider/orderDetailProvider.dart';
import 'package:egrocer_seller/helper/provider/userProfileProvider.dart';
import 'package:egrocer_seller/screens/accountTypeScreen.dart';
import 'package:egrocer_seller/screens/loginAccountScreen.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/mainHomeScreen.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/orderDetailScreen/orderDetailScreen.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/profileMenuScreen/screens/editProfileScreen.dart';
import 'package:egrocer_seller/screens/splashScreen.dart';
import 'package:egrocer_seller/screens/webViewScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String splashScreen = 'splashScreen';
const String accountTypeScreen = 'accountTypeScreen';
const String loginScreen = 'loginScreen';
const String mainHomeScreen = 'mainHomeScreen';
const String webViewScreen = 'webViewScreen';
const String editProfileScreen = 'editProfileScreen';
const String orderDetail = 'orderDetail';

String currentRoute = splashScreen;

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "";

    switch (settings.name) {
      case splashScreen:
        return CupertinoPageRoute(
          builder: (_) => SplashScreen(),
        );

      case accountTypeScreen:
        return CupertinoPageRoute(
          builder: (_) => AccountTypeScreen(),
        );

      case loginScreen:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<UserProfileProvider>(
            create: (context) => UserProfileProvider(),
            child: LoginAccountScreen(),
          ),
        );

      case mainHomeScreen:
        return CupertinoPageRoute(
          builder: (_) => MainHomeScreen(),
        );

      case webViewScreen:
        return CupertinoPageRoute(
          builder: (_) => WebViewScreen(dataFor: settings.arguments as String),
        );

      case editProfileScreen:
        return CupertinoPageRoute(
          builder: (_) => EditProfile(from: settings.arguments as String),
        );

      case orderDetail:
        return CupertinoPageRoute(
          builder: (_) => ChangeNotifierProvider<OrderDetailProvider>(
            create: (context) => OrderDetailProvider(),
            child: OrderDetailScreen(orderId: settings.arguments as String),
          ),
        );
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

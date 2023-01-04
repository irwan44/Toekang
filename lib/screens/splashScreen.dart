import 'dart:async';

import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/sessionManager.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/routeGenerator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 2),
    ).then((value) async {
      if (Constant.session.isUserLoggedIn()) {
        Navigator.pushReplacementNamed(context, mainHomeScreen);
      } else {
        if (Constant.appLoginType == 1) {
          Constant.session.setData(SessionManager.keyUserType, "seller", false);
          Navigator.pushNamed(context, loginScreen);
        } else if (Constant.appLoginType == 2) {
          Constant.session
              .setData(SessionManager.keyUserType, "delivery_boy", false);

          Navigator.pushNamed(context, loginScreen);
        } else {
          Navigator.pushReplacementNamed(context, accountTypeScreen);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Text("Toekang",style: TextStyle(
          color: Colors.green,
          fontSize: 70,
          fontWeight: FontWeight.bold,
        ),),
      ),
    );
  }
}

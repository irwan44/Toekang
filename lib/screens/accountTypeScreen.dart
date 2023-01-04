import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/sessionManager.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/routeGenerator.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:flutter/material.dart';

class AccountTypeScreen extends StatefulWidget {
  AccountTypeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountTypeScreen> createState() => _LoginAccountState();
}

class _LoginAccountState extends State<AccountTypeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PositionedDirectional(
            bottom: 0,
            start: 0,
            end: 0,
            top: 0,
            child: Image.asset(
              Constant.getAssetsPath(0, "bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            start: 0,
            end: 0,
            top: 0,
            child: Image.asset(
              Constant.getAssetsPath(0, "bg_overlay.png"),
              fit: BoxFit.fill,
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            start: 0,
            end: 0,
            top: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Widgets.getSizedBox(height: 30),
                    Text(
                      StringsRes.lblLoginTypePageTitle,
                      softWrap: true,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: ColorsRes.appColorWhite,
                          fontWeight: FontWeight.w500
                          ),
                    ),
                    Widgets.getSizedBox(height: 10),
                    Text(
                      StringsRes.lblLoginTypePageDescription,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: ColorsRes.appColorWhite,
                        fontWeight: FontWeight.w300
                          ),
                    ),
                    Spacer(),
                    Text(
                      StringsRes.lblLoginAs,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: ColorsRes.appColorWhite,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    Widgets.getSizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Widgets.gradientBtnWidget(
                            context,
                            10,
                            isSetShadow: false,
                            otherWidgets: Text(
                              StringsRes.lblSeller,
                              softWrap: true,
                              style:
                                  Theme.of(context).textTheme.subtitle1!.merge(
                                        TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                            ),
                            callback: () {
                              Constant.session.setData(
                                  SessionManager.keyUserType, "seller", false);
                              Navigator.pushNamed(context, loginScreen);
                            },
                          ),
                        ),
                        Widgets.getSizedBox(width: 10),
                        Expanded(
                          child: Widgets.gradientBtnWidget(
                            context,
                            10,
                            isSetShadow: false,
                            otherWidgets: Text(
                              StringsRes.lblDeliveryBoy,
                              softWrap: true,
                              style:
                                  Theme.of(context).textTheme.subtitle1!.merge(
                                        TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.w500),
                                      ),
                            ),
                            callback: () {
                              Constant.session.setData(
                                  SessionManager.keyUserType,
                                  "delivery_boy",
                                  false);

                              Navigator.pushNamed(context, loginScreen);
                            },
                          ),
                        ),
                      ],
                    ),
                    Widgets.getSizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

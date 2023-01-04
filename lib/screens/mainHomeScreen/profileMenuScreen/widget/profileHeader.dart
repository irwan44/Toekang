import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/sessionManager.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/styles/designConfig.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/routeGenerator.dart';
import 'package:flutter/material.dart';

profileHeader({required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, editProfileScreen, arguments: "");
    },
    child: Card(
      elevation: 0,
      margin: EdgeInsetsDirectional.only(bottom: 5, start: 3, end: 3),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 12),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      Constant.session.getData(SessionManager.keyUserName),
                    ),
                    subtitle: Text(
                      Constant.session.getData(SessionManager.keyPhone),
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .apply(color: ColorsRes.appColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              decoration: DesignConfig.boxGradient(5),
              padding: EdgeInsets.all(5),
              margin: EdgeInsetsDirectional.only(end: 8, top: 8),
              child: Widgets.defaultImg(
                  image: "edit_icon",
                  iconColor: Colors.white,
                  height: 20,
                  width: 20),
            ),
          ),
        ],
      ),
    ),
  );
}

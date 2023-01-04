import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:flutter/material.dart';

Widget getStatisticsContainer({required BuildContext context,
  required String svgIconName,
  required Color bgColor,
  required String title,
  required String itemCount}) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: ColorsRes.appColorWhite,
          radius: 35,
          child: Widgets.defaultImg(
            image: svgIconName,
            iconColor: bgColor,
            width: 30,
            height: 30,
          ),
        ),
        Widgets.getSizedBox(height: 15),
        Text(
          itemCount,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            color: ColorsRes.appColorWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        Widgets.getSizedBox(height: 5),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: ColorsRes.appColorWhite,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:flutter/material.dart';

getItemDetailContainer({required String title, required String value}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          title,
          softWrap: true,
          style: TextStyle(color: ColorsRes.grey),
        ),
      ),
      Widgets.getSizedBox(width: 10),
      Expanded(
        child: Text(
          value,
          softWrap: true,
          style: TextStyle(color: ColorsRes.mainTextColor),
        ),
      ),
    ],
  );
}

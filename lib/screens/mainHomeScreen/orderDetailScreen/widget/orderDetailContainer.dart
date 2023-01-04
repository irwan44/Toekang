import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:flutter/material.dart';

getOrderDetailContainer({required String title, required String value}) {
  return Row(
    children: [
      Expanded(
        flex: 5,
        child: Text(
          title,
          softWrap: true,
          style: TextStyle(color: ColorsRes.grey),
        ),
      ),
      Widgets.getSizedBox(width: 10),
      Expanded(
        flex: 10,
        child: Text(
          value,
          softWrap: true,
          style: TextStyle(color: ColorsRes.mainTextColor),
        ),
      ),
    ],
  );
}

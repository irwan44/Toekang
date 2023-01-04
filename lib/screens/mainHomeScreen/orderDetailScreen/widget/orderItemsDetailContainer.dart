import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/styles/designConfig.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:egrocer_seller/models/orderDetail.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/orderDetailScreen/widget/orderItemsWidget.dart';
import 'package:flutter/material.dart';

getOrderItemDetailsContainer(
    {required BuildContext context, OrderItems? orderItem}) {
  double price = orderItem?.price ?? 0.0;
  double? discountedPrice = orderItem?.discountedPrice ?? 0.0;
  return Container(
    padding: EdgeInsets.all(Constant.paddingOrMargin10),
    margin: EdgeInsetsDirectional.only(
      bottom: Constant.paddingOrMargin10,
    ),
    decoration: DesignConfig.boxDecoration(
      Theme.of(context).cardColor,
      10,
    ),
    child: Column(
      children: [
        getItemDetailContainer(
            title: StringsRes.lblName, value: orderItem?.productName ?? ""),
        Widgets.getSizedBox(height: 10),
        getItemDetailContainer(
            title: StringsRes.lblVariant, value: orderItem?.variantName ?? ""),
        Widgets.getSizedBox(height: 10),
        getItemDetailContainer(
            title: StringsRes.lblQuantity,
            value: orderItem?.quantity.toString() ?? "1"),
        Widgets.getSizedBox(height: 10),
        getItemDetailContainer(
          title: StringsRes.lblPrice,
          value: GeneralMethods.getCurrencyFormat(
              discountedPrice.compareTo(0.0) == 0 ? price : discountedPrice),
        ),
        Widgets.getSizedBox(height: 10),
        getItemDetailContainer(
          title: StringsRes.lblTax,
          value: "${GeneralMethods.getCurrencyFormat(
            (orderItem?.taxAmount ?? 0.0) * (orderItem?.quantity ?? 1),
          )} (Qty x ${orderItem?.taxPercentage ?? 0.0}% Tax)",
        ),
        Widgets.getSizedBox(height: 10),
        getItemDetailContainer(
          title: StringsRes.lblSubtotal,
          value: GeneralMethods.getCurrencyFormat(orderItem?.subTotal ?? 0.0),
        ),
      ],
    ),
  );
}

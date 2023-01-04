import 'package:egrocer_seller/helper/generalWidgets/bottomSheetDeliveryBoysContainer.dart';
import 'package:egrocer_seller/helper/generalWidgets/bottomSheetStatusContainer.dart';
import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/provider/deliveryBoysProvider.dart';
import 'package:egrocer_seller/helper/provider/orderDetailProvider.dart';
import 'package:egrocer_seller/helper/provider/ordersUpdateProvider.dart';
import 'package:egrocer_seller/helper/sessionManager.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/styles/designConfig.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:egrocer_seller/models/orderDetail.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/orderDetailScreen/widget/orderDetailContainer.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/orderDetailScreen/widget/orderItemsDetailContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    //fetch categoryList from api
    Future.delayed(Duration.zero).then((value) {
      context
          .read<OrderDetailProvider>()
          .getOrderDetail(context: context, orderId: widget.orderId);
    });
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: Text(
          "${StringsRes.lblTitleOrder} #${widget.orderId}",
          style: TextStyle(color: ColorsRes.mainTextColor),
        ),
      ),
      body: Consumer<OrderDetailProvider>(
        builder: (context, orderDetailProvider, child) {
          if (orderDetailProvider.orderDetailState == OrderDetailState.loaded) {
            Order? order = orderDetailProvider.orderDetail.data?.order;
            List<OrderItems>? orderItems =
                orderDetailProvider.orderDetail.data?.orderItems;
            return setRefreshIndicator(
              refreshCallback: () {
                return orderDetailProvider.getOrderDetail(
                    context: context, orderId: widget.orderId);
              },
              child: Padding(
                padding: EdgeInsetsDirectional.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Text(
                            StringsRes.lblOrderDetails,
                            style: TextStyle(
                                color: ColorsRes.appColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          Widgets.getSizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(Constant.paddingOrMargin10),
                            margin: EdgeInsetsDirectional.only(
                              bottom: Constant.paddingOrMargin10,
                            ),
                            decoration: DesignConfig.boxDecoration(
                              Theme.of(context).cardColor,
                              10,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getOrderDetailContainer(
                                      title: StringsRes.lblUserName,
                                      value: order?.userName ?? ""),
                                  Widgets.getSizedBox(height: 10),
                                  getOrderDetailContainer(
                                      title: StringsRes.lblUserEmail,
                                      value: order?.userEmail ?? ""),
                                  Widgets.getSizedBox(height: 10),
                                  getOrderDetailContainer(
                                      title: StringsRes.lblUserMobile,
                                      value: order?.mobile ?? ""),
                                  if (order!.orderNote!.isNotEmpty)
                                    Widgets.getSizedBox(height: 10),
                                  if (order.orderNote!.isNotEmpty)
                                    getOrderDetailContainer(
                                        title: StringsRes.lblOrderNote,
                                        value: order.orderNote ?? ""),
                                ]),
                          ),
                          Text(
                            StringsRes.lblBillingDetails,
                            style: TextStyle(
                                color: ColorsRes.appColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          Widgets.getSizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(Constant.paddingOrMargin10),
                            margin: EdgeInsetsDirectional.only(
                              bottom: Constant.paddingOrMargin10,
                            ),
                            decoration: DesignConfig.boxDecoration(
                              Theme.of(context).cardColor,
                              10,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getOrderDetailContainer(
                                    title: StringsRes.lblOrderDate,
                                    value: GeneralMethods.formatDate(
                                      DateTime.parse(order.orderDate ?? ""),
                                    ),
                                  ),
                                  Widgets.getSizedBox(height: 10),
                                  getOrderDetailContainer(
                                      title: StringsRes.lblDeliveryTime,
                                      value: order.deliveryTime ?? ""),
                                  Widgets.getSizedBox(height: 10),
                                  getOrderDetailContainer(
                                      title: StringsRes.lblAddress,
                                      value: order.address ?? ""),
                                  Widgets.getSizedBox(height: 10),
                                  getOrderDetailContainer(
                                    title: StringsRes.lblDeliveryCharge,
                                    value: GeneralMethods.getCurrencyFormat(
                                        order.deliveryCharge ?? 0.0),
                                  ),
                                  Widgets.getSizedBox(height: 10),
                                  getOrderDetailContainer(
                                    title: StringsRes.lblTotalItemsAmount,
                                    value: GeneralMethods.getCurrencyFormat(
                                        order.total ?? 0.0),
                                  ),
                                  Widgets.getSizedBox(height: 10),
                                  getOrderDetailContainer(
                                    title: StringsRes.lblPayableAmount,
                                    value: GeneralMethods.getCurrencyFormat(
                                        order.finalTotal ?? 0.0),
                                  ),
                                  Widgets.getSizedBox(height: 10),
                                  getOrderDetailContainer(
                                      title: StringsRes.lblPaymentMethod,
                                      value: order.paymentMethod ?? ""),
                                ]),
                          ),
                          Text(
                            StringsRes.lblListOfOrderItems,
                            style: TextStyle(
                                color: ColorsRes.appColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          Widgets.getSizedBox(height: 10),
                          Column(
                            children:
                                List.generate(orderItems?.length ?? 0, (index) {
                              return getOrderItemDetailsContainer(
                                  context: context,
                                  orderItem: orderItems?[index]);
                            }),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (Constant.session
                                .getData(SessionManager.keyUserType) ==
                            "seller")
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: DesignConfig.setRoundedBorderSpecific(
                                      20,
                                      istop: true),
                                  builder: (BuildContext context) {
                                    return ChangeNotifierProvider(
                                      create: (context) =>
                                          DeliveryBoysProvider(),
                                      child: Wrap(
                                        children: [
                                          BottomSheetDeliveryBoysContainer(
                                            orderId: order.orderId.toString(),
                                            deliveryBoyId:
                                                "${order.deliveryBoyId == null ? "0" : order.deliveryBoyId.toString()}",
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                alignment: AlignmentDirectional.centerStart,
                                margin: EdgeInsetsDirectional.only(end: 5),
                                padding: EdgeInsetsDirectional.all(
                                    Constant.paddingOrMargin5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ColorsRes.appColor, width: 1),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            StringsRes.lblDeliveryBoy,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: ColorsRes.grey),
                                            softWrap: true,
                                          ),
                                          Widgets.getSizedBox(height: 2),
                                          Text(
                                            "${order.deliveryBoyName != null ? order.deliveryBoyName : StringsRes.lblNotAssign}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                shape: DesignConfig.setRoundedBorderSpecific(20,
                                    istop: true),
                                builder: (BuildContext context) {
                                  return ChangeNotifierProvider(
                                    create: (context) => OrderUpdateProvider(),
                                    child: Wrap(
                                      children: [
                                        BottomSheetStatusContainer(
                                          orderId: order.orderId.toString(),
                                          statusId: /*order?.activeStatus ??*/ "0",
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              alignment: AlignmentDirectional.centerStart,
                              padding: EdgeInsetsDirectional.all(
                                  Constant.paddingOrMargin5),
                              margin: EdgeInsetsDirectional.only(start: 5),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: ColorsRes.appColor, width: 1),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          StringsRes.lblStatus,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: ColorsRes.grey),
                                          softWrap: true,
                                        ),
                                        Widgets.getSizedBox(height: 2),
                                        Text(
                                          StringsRes.lblOrderStatusDisplayNames[
                                              int.parse(
                                                  /*order?.activeStatus ??*/
                                                  "5")],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else if (orderDetailProvider.orderDetailState ==
              OrderDetailState.loading) {
            return ListView(
              padding: EdgeInsetsDirectional.all(10),
              children: [
                Text(
                  StringsRes.lblOrderDetails,
                  style: TextStyle(
                      color: ColorsRes.appColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                Widgets.getSizedBox(height: 10),
                CustomShimmer(
                  height: 90,
                  width: double.maxFinite,
                  borderRadius: 10,
                ),
                Widgets.getSizedBox(height: 10),
                Text(
                  StringsRes.lblBillingDetails,
                  style: TextStyle(
                      color: ColorsRes.appColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                Widgets.getSizedBox(height: 10),
                CustomShimmer(
                  height: 220,
                  width: double.maxFinite,
                  borderRadius: 10,
                ),
                Widgets.getSizedBox(height: 10),
                Text(
                  StringsRes.lblListOfOrderItems,
                  style: TextStyle(
                      color: ColorsRes.appColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                Widgets.getSizedBox(height: 10),
                Column(
                  children: List.generate(
                    10,
                    (index) => CustomShimmer(
                      height: 160,
                      width: double.maxFinite,
                      borderRadius: 10,
                      margin: EdgeInsets.only(bottom: 10),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

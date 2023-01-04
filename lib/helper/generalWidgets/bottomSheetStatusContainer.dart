import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/provider/ordersUpdateProvider.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/utils/apiAndParams.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetStatusContainer extends StatefulWidget {
  final String orderId;
  final String statusId;

  BottomSheetStatusContainer(
      {Key? key, required this.orderId, required this.statusId})
      : super(key: key);

  @override
  State<BottomSheetStatusContainer> createState() =>
      _BottomSheetStatusContainerState();
}

class _BottomSheetStatusContainerState
    extends State<BottomSheetStatusContainer> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      context.read<OrderUpdateProvider>().setSelectedStatus(
            int.parse(widget.statusId),
          );
      await context
          .read<OrderUpdateProvider>()
          .getOrdersStatuses(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderUpdateProvider>(
      builder: (context, ordersProvider, child) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(
                  start: Constant.paddingOrMargin15,
                  end: Constant.paddingOrMargin15,
                  top: Constant.paddingOrMargin15,
                  bottom: Constant.paddingOrMargin15),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      StringsRes.lblUpdateOrderStatus,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1!.merge(
                            TextStyle(letterSpacing: 0.5),
                          ),
                    ),
                  ),
                  Widgets.getSizedBox(height: 10),
                  if (ordersProvider.ordersStatusState ==
                          OrderUpdateStatusState.loaded ||
                      ordersProvider.ordersStatusState ==
                          OrderUpdateStatusState.loading)
                    Column(
                      children: [
                        Column(
                          children: List.generate(
                              ordersProvider.orderStatusesList.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                ordersProvider.setSelectedStatus(index);
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            start: Constant.paddingOrMargin10),
                                        child: Text(ordersProvider
                                                .orderStatusesList[index]
                                                .status ??
                                            ""),
                                      ),
                                    ),
                                    Radio(
                                      activeColor: ColorsRes.appColor,
                                      value: ordersProvider.selectedOrderStatus,
                                      groupValue: ordersProvider
                                          .orderStatusesList[index].id,
                                      onChanged: (value) {
                                        ordersProvider.setSelectedStatus(
                                            ordersProvider
                                                    .orderStatusesList[index]
                                                    .id ??
                                                0);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        Widgets.getSizedBox(height: 10),
                        Widgets.gradientBtnWidget(context, 10, callback: () {
                          Map<String, String> params = {};
                          params[ApiAndParams.orderId] = widget.orderId;
                          params[ApiAndParams.statusId] =
                              ordersProvider.selectedOrderStatus.toString();
                          ordersProvider
                              .updateOrdersStatus(
                                  params: params, context: context)
                              .then(
                                (value) => Navigator.pop(context),
                              );
                        },
                            isSetShadow: false,
                            title: StringsRes.lblUpdateOrderStatus),
                      ],
                    ),
                  if (ordersProvider.ordersStatusState ==
                      OrderUpdateStatusState.loading)
                    Column(
                      children: List.generate(8, (index) {
                        return CustomShimmer(
                          height: 30,
                          width: double.maxFinite,
                          margin: EdgeInsetsDirectional.all(10),
                        );
                      }),
                    ),
                ],
              ),
            ),
            if (ordersProvider.ordersStatusState ==
                OrderUpdateStatusState.loading)
              PositionedDirectional(
                  top: 0,
                  end: 0,
                  start: 0,
                  bottom: 0,
                  child: Container(
                    color: ColorsRes.appColorBlack.withOpacity(0.2),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ))
          ],
        );
      },
    );
  }
}

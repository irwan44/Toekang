import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/provider/deliveryBoysProvider.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/utils/apiAndParams.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetDeliveryBoysContainer extends StatefulWidget {
  final String orderId;
  final String deliveryBoyId;

  BottomSheetDeliveryBoysContainer(
      {Key? key, required this.orderId, required this.deliveryBoyId})
      : super(key: key);

  @override
  State<BottomSheetDeliveryBoysContainer> createState() =>
      _BottomSheetDeliveryBoysContainerState();
}

class _BottomSheetDeliveryBoysContainerState
    extends State<BottomSheetDeliveryBoysContainer> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      context.read<DeliveryBoysProvider>().selectedDeliveryBoy =
          int.parse(widget.deliveryBoyId);
      await context.read<DeliveryBoysProvider>().getDeliveryBoys(
          selectedDeliveryBoyIndex: int.parse(
            widget.deliveryBoyId.toString(),
          ),
          context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DeliveryBoysProvider>(
      builder: (context, deliveryBoysProvider, child) {
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
                  if (deliveryBoysProvider.deliveryBoysState ==
                          DeliveryBoysState.loaded ||
                      deliveryBoysProvider.deliveryBoysState ==
                          DeliveryBoysState.loadingMore)
                    Column(
                      children: [
                        Column(
                          children: List.generate(
                              deliveryBoysProvider.deliveryBoysList.length,
                              (index) {
                            return GestureDetector(
                              onTap: () {
                                deliveryBoysProvider.setSelectedIndex(int.parse(
                                  deliveryBoysProvider
                                      .deliveryBoysList[index].id
                                      .toString(),
                                ));
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            start: Constant.paddingOrMargin10),
                                        child: Text(
                                            "${deliveryBoysProvider.deliveryBoysList[index].name ?? ""}(${StringsRes.lblPendingOrders} - ${deliveryBoysProvider.deliveryBoysList[index].pendingOrderCount ?? "0"})"),
                                      ),
                                    ),
                                    Radio(
                                      activeColor: ColorsRes.appColor,
                                      value: deliveryBoysProvider
                                          .selectedDeliveryBoy,
                                      groupValue: deliveryBoysProvider
                                          .deliveryBoysList[index].id,
                                      onChanged: (value) {
                                        deliveryBoysProvider
                                            .setSelectedIndex(int.parse(
                                          deliveryBoysProvider
                                              .deliveryBoysList[index].id
                                              .toString(),
                                        ));
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
                          params[ApiAndParams.deliveryBoyId] =
                              deliveryBoysProvider.selectedDeliveryBoy
                                  .toString();
                          deliveryBoysProvider
                              .updateOrdersDeliveryBoy(
                                  params: params, context: context)
                              .then(
                                (value) => Navigator.pop(context),
                              );
                        },
                            isSetShadow: false,
                            title: StringsRes.lblUpdateDeliveryBoy)
                      ],
                    ),
                  if (deliveryBoysProvider.deliveryBoysState ==
                      DeliveryBoysState.loading)
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
            if (deliveryBoysProvider.deliveryBoysState ==
                DeliveryBoysState.deliveryBoyUpdating)
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

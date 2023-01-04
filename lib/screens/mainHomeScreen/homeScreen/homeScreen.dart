import 'package:egrocer_seller/helper/generalWidgets/bottomSheetStatusContainer.dart';
import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/provider/dashBoardProvider.dart';
import 'package:egrocer_seller/helper/provider/ordersProvider.dart';
import 'package:egrocer_seller/helper/provider/ordersUpdateProvider.dart';
import 'package:egrocer_seller/helper/provider/settingsProvider.dart';
import 'package:egrocer_seller/helper/sessionManager.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/styles/designConfig.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/helper/utils/routeGenerator.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:egrocer_seller/models/deliveryBoyOrders.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/homeScreen/widget/categoryPieChart.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/homeScreen/widget/homeStatisticsContainer.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/homeScreen/widget/weeklySalesBarChart.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/orderListScreen/widget/ordersStatusContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController scrollController = ScrollController()
    ..addListener(activeOrdersScrollListener);

  void activeOrdersScrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context.read<OrdersProvider>().hasMoreData) {
        context.read<OrdersProvider>().getOrders(
              context: context,
              statusIndex:
                  context.read<OrdersProvider>().selectedStatus.toString(),
            );
      }
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<SettingsProvider>().getSettingsApiProvider({}, context).then(
        (value) => context
            .read<DashboardProvider>()
            .dashboardApiProvider({}, context).then((value) {
          if (Constant.session.getData(SessionManager.keyUserType) !=
              "seller") {
            context
                .read<OrdersProvider>()
                .getOrders(statusIndex: "0", context: context);
          }
        }),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(
          context: context,
          title: Text(
            "Home",
            style: TextStyle(color: ColorsRes.mainTextColor),
          ),
          centerTitle: true),
      body: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, _) {
          if (Constant.session.getData(SessionManager.keyUserType) ==
              "seller") {
            return dashboardProvider.dashboardState == DashboardState.loaded
                ? setRefreshIndicator(
                    refreshCallback: () async {
                      await context
                          .read<DashboardProvider>()
                          .dashboardApiProvider({}, context);
                    },
                    child: ListView(
                      children: [
                        GridView.count(
                          childAspectRatio: 1,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          crossAxisCount: 2,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsetsDirectional.all(10),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: [
                            getStatisticsContainer(
                                context: context,
                                bgColor: ColorsRes.sellerStatisticsColors[0],
                                svgIconName: "orders",
                                title: StringsRes.lblOrders,
                                itemCount: dashboardProvider
                                        .dashBoard.data?.orderCount
                                        .toString() ??
                                    "0"),
                            getStatisticsContainer(
                                context: context,
                                bgColor: ColorsRes.sellerStatisticsColors[1],
                                svgIconName: "products",
                                title: StringsRes.lblProducts,
                                itemCount: dashboardProvider
                                        .dashBoard.data?.productCount
                                        .toString() ??
                                    "0"),
                            getStatisticsContainer(
                                svgIconName: "sold_out_products",
                                bgColor: ColorsRes.sellerStatisticsColors[2],
                                context: context,
                                title: StringsRes.lblSoldOutProducts,
                                itemCount: dashboardProvider
                                        .dashBoard.data?.soldOutCount
                                        .toString() ??
                                    "0"),
                            getStatisticsContainer(
                                svgIconName: "low_stock_products",
                                bgColor: ColorsRes.sellerStatisticsColors[3],
                                context: context,
                                title: StringsRes.lblLowStockProducts,
                                itemCount: dashboardProvider
                                        .dashBoard.data?.lowStockCount
                                        .toString() ??
                                    "0"),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: WeeklySalesBarChart(
                            weeklySales:
                                dashboardProvider.dashBoard.data?.weeklySales ??
                                    [],
                              maxSaleLimit:dashboardProvider.maxSaleLimit
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CategoryPieChart(
                            categoryProductCounts: dashboardProvider
                                    .dashBoard.data?.categoryProductCount ??
                                [],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    children: [
                      GridView.count(
                        childAspectRatio: 1,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsetsDirectional.all(10),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: [
                          CustomShimmer(
                              width: double.maxFinite,
                              borderRadius: 10,
                              height: 150),
                          CustomShimmer(
                              width: double.maxFinite,
                              borderRadius: 10,
                              height: 150),
                          CustomShimmer(
                              width: double.maxFinite,
                              borderRadius: 10,
                              height: 150),
                          CustomShimmer(
                              width: double.maxFinite,
                              borderRadius: 10,
                              height: 150),
                        ],
                      ),
                      CustomShimmer(
                        width: double.maxFinite,
                        borderRadius: 10,
                        height: 300,
                        margin: EdgeInsetsDirectional.only(
                          start: 10,
                          end: 10,
                        ),
                      ),
                      CustomShimmer(
                        width: double.maxFinite,
                        borderRadius: 10,
                        height: 150,
                        margin: EdgeInsetsDirectional.all(10),
                      ),
                    ],
                  );
          } else {
            if (dashboardProvider.dashboardState == DashboardState.loaded) {
              return setRefreshIndicator(
                refreshCallback: () async {
                  await context
                      .read<DashboardProvider>()
                      .dashboardApiProvider({}, context);
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      GridView.count(
                        childAspectRatio: 1,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsetsDirectional.all(10),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: [
                          getStatisticsContainer(
                              context: context,
                              bgColor: ColorsRes.sellerStatisticsColors[0],
                              svgIconName: "orders",
                              title: StringsRes.lblOrders,
                              itemCount: dashboardProvider
                                      .dashBoard.data?.orderCount
                                      .toString() ??
                                  "0"),
                          getStatisticsContainer(
                              context: context,
                              svgIconName: "balance",
                              bgColor: ColorsRes.sellerStatisticsColors[1],
                              title: StringsRes.lblBalance,
                              itemCount: dashboardProvider
                                      .dashBoard.data?.balance
                                      .toString() ??
                                  "0"),
                        ],
                      ),
                      Container(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(9, (index) {
                            return GestureDetector(
                              onTap: () async {
                                if (mounted) {
                                  await context
                                      .read<OrdersProvider>()
                                      .changeOrderSelectedStatus(index)
                                      .then((value) async {
                                    if (value) {
                                      await context
                                          .read<OrdersProvider>()
                                          .getOrders(
                                              statusIndex: index.toString(),
                                              context: context);
                                    }
                                  });
                                }
                              },
                              child: getOrderStatusContainer(
                                isActive: context
                                        .watch<OrdersProvider>()
                                        .selectedStatus ==
                                    index,
                                svgIconName: Constant.orderStatusIcons[index],
                                context: context,
                                title: StringsRes
                                    .lblOrderStatusDisplayNames[index],
                              ),
                            );
                          }),
                        ),
                      ),
                      Consumer<OrdersProvider>(
                        builder: (context, ordersProvider, child) {
                          if (ordersProvider.ordersState ==
                                  OrdersState.loaded ||
                              ordersProvider.ordersState ==
                                  OrdersState.loadingMore) {
                            return Column(
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: ordersProvider
                                        .deliveryBoyOrdersList.length,
                                    itemBuilder: (context, index) {
                                      if (index ==
                                          ordersProvider.deliveryBoyOrdersList
                                                  .length -
                                              1) {
                                        if (ordersProvider.ordersState ==
                                            OrdersState.loadingMore) {
                                          return _buildOrderContainerShimmer();
                                        }
                                      }
                                      return _buildOrderContainer(ordersProvider
                                          .deliveryBoyOrdersList[index]);
                                    }),
                              ],
                            );
                          } else if (ordersProvider.ordersState ==
                                  OrdersState.loaded ||
                              ordersProvider.ordersState ==
                                  OrdersState.loading) {
                            return Column(
                              children: List.generate(
                                20,
                                (index) => _buildOrderContainerShimmer(),
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return ListView(
                children: [
                  GridView.count(
                    childAspectRatio: 1,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsetsDirectional.all(10),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      CustomShimmer(
                          width: double.maxFinite,
                          borderRadius: 10,
                          height: 150),
                      CustomShimmer(
                          width: double.maxFinite,
                          borderRadius: 10,
                          height: 150),
                      CustomShimmer(
                          width: double.maxFinite,
                          borderRadius: 10,
                          height: 150),
                      CustomShimmer(
                          width: double.maxFinite,
                          borderRadius: 10,
                          height: 150),
                    ],
                  ),
                  CustomShimmer(
                    width: double.maxFinite,
                    borderRadius: 10,
                    height: 300,
                    margin: EdgeInsetsDirectional.only(
                      start: 10,
                      end: 10,
                    ),
                  ),
                  CustomShimmer(
                    width: double.maxFinite,
                    borderRadius: 10,
                    height: 150,
                    margin: EdgeInsetsDirectional.all(10),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }

  _buildOrderContainer(DeliveryBoyOrdersListItem order) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          orderDetail,
          arguments: order.orderId.toString(),
        );
      },
      child: Container(
        padding: EdgeInsets.all(Constant.paddingOrMargin10),
        margin: EdgeInsetsDirectional.only(
            start: Constant.paddingOrMargin10,
            bottom: Constant.paddingOrMargin10,
            end: Constant.paddingOrMargin10),
        decoration: DesignConfig.boxDecoration(
          Theme.of(context).cardColor,
          10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "ID #${order.id}",
                    softWrap: true,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Widgets.getSizedBox(width: 10),
                Text(
                  GeneralMethods.getCurrencyFormat(
                    double.parse(
                      order.finalTotal.toString(),
                    ),
                  ),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorsRes.appColor),
                  softWrap: true,
                ),
              ],
            ),
            Widgets.getSizedBox(height: 10),
            Divider(height: 1, color: ColorsRes.grey, thickness: 0),
            Widgets.getSizedBox(height: 10),
            Text(
              StringsRes.lblPaymentMethod,
              style: TextStyle(fontSize: 14, color: ColorsRes.grey),
              softWrap: true,
            ),
            Widgets.getSizedBox(height: 2),
            Text(
              "${order.paymentMethod}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              softWrap: true,
            ),
            Widgets.getSizedBox(height: 20),
            Text(
              StringsRes.lblDeliveryTime,
              style: TextStyle(fontSize: 14, color: ColorsRes.grey),
              softWrap: true,
            ),
            Widgets.getSizedBox(height: 2),
            Text(
              "${order.deliveryTime ?? ""}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              softWrap: true,
            ),
            Widgets.getSizedBox(height: 10),
            Divider(height: 1, color: ColorsRes.grey, thickness: 0),
            Widgets.getSizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                                  orderId: order.id.toString(),
                                  statusId: order.activeStatus ?? "0",
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      padding:
                          EdgeInsetsDirectional.all(Constant.paddingOrMargin5),
                      margin: EdgeInsetsDirectional.only(start: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorsRes.appColor, width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringsRes.lblStatus,
                                  style: TextStyle(
                                      fontSize: 14, color: ColorsRes.grey),
                                  softWrap: true,
                                ),
                                Widgets.getSizedBox(height: 2),
                                Text(
                                  StringsRes.lblOrderStatusDisplayNames[
                                      int.parse(order.activeStatus ?? "0")],
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
  }

  _buildOrderContainerShimmer() {
    return CustomShimmer(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      borderRadius: 10,
      margin: EdgeInsetsDirectional.only(
          start: Constant.paddingOrMargin10,
          end: Constant.paddingOrMargin10,
          bottom: Constant.paddingOrMargin10),
    );
  }
}

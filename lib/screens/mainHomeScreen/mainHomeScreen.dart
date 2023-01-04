import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/provider/categoryProvider.dart';
import 'package:egrocer_seller/helper/provider/dashBoardProvider.dart';
import 'package:egrocer_seller/helper/provider/ordersProvider.dart';
import 'package:egrocer_seller/helper/provider/settingsProvider.dart';
import 'package:egrocer_seller/helper/sessionManager.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/categoryListScreen/categoryListScreen.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/homeScreen/homeScreen.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/orderListScreen/orderListScreen.dart';
import 'package:egrocer_seller/screens/mainHomeScreen/profileMenuScreen/profileMenuScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainHomeScreen extends StatefulWidget {
  MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<MainHomeScreen> {
  NetworkStatus networkStatus = NetworkStatus.Online;
  int currentPage = 0;

  //total pageListing
  List<Widget> pages = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    checkConnectionState();

    if (Constant.session.getData(SessionManager.keyUserType) == "seller") {
      pages = [
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => DashboardProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => SettingsProvider(),
            ),
          ],
          child: HomeScreen(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrdersProvider(),
          child: OrderListScreen(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryListProvider(),
          child: CategoryListScreen(),
        ),
        ProfileScreen()
      ];
    } else {
      pages = [
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => OrdersProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => DashboardProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => SettingsProvider(),
            ),
          ],
          child: HomeScreen(),
        ),
        ProfileScreen()
      ];
    }

    super.initState();
  }

  //internet connection checking
  checkConnectionState() async {
    networkStatus = await GeneralMethods.checkInternet()
        ? NetworkStatus.Online
        : NetworkStatus.Offline;
    Connectivity().onConnectivityChanged.listen((status) {
      if (mounted) {
        setState(() {
          networkStatus = GeneralMethods.getNetworkStatus(status);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Widgets.homeBottomNavigation(
          currentPage, selectBottomMenu, pages.length, context),
      body: networkStatus == NetworkStatus.Online
          ? WillPopScope(
              onWillPop: () {
                if (currentPage == 0) {
                  return Future.value(true);
                } else {
                  if (mounted) {
                    setState(() {
                      currentPage = 0;
                    });
                  }
                  return Future.value(false);
                }
              },
              child: IndexedStack(
                index: currentPage,
                children: pages,
              ),
            )
          : Center(
              child: Text(StringsRes.lblCheckInternet),
            ),
    );
  }

  //change current screen based on bottom menu selection
  selectBottomMenu(int index) {
    if (mounted) {
      currentPage = index;
      setState(() {});
    }
  }
}

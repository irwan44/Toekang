import 'dart:io';

import 'package:egrocer_seller/helper/generalWidgets/widgets.dart';
import 'package:egrocer_seller/helper/styles/colorsRes.dart';
import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/routeGenerator.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget/profileHeader.dart';
import 'widget/profileMenuWidget.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List profileMenus = [];
  bool isUserLogin = Constant.session.isUserLoggedIn();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setProfileMenuList();
    });
  }

  @override
  Widget build(BuildContext context) {
    setProfileMenuList();

    return Scaffold(
      appBar: getAppBar(
        context: context,
        title: Text(
          StringsRes.lblTitleProfile,
          softWrap: true,
          style: TextStyle(color: ColorsRes.mainTextColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(children: [
          profileHeader(context: context),
          SizedBox(height: 1),
          Flexible(
            child: Card(
              child: profileMenuWidget(profileMenus: profileMenus),
            ),
          )
        ]),
      ),
    );
  }

  setProfileMenuList() {
    profileMenus = [];
    profileMenus = [
      {
        "icon": "theme_icon",
        "label": StringsRes.lblChangeTheme,
        "clickFunction": Widgets.themeDialog,
      },
      {
        "icon": "translate_icon",
        "label": StringsRes.lblChangeLanguage,
        "clickFunction": Widgets.langDialog,
        "isResetLabel": true,
      },
/*      if (isUserLogin)
        {
          "icon": "notification_icon",
          "label": StringsRes.lblNotification,
          "clickFunction": (context) {
            Navigator.pushNamed(context, notificationListScreen);
          },
          "isResetLabel": false
        },
      if (isUserLogin)
        {
          "icon": "transaction_icon",
          "label": StringsRes.lblTransactionHistory,
          "clickFunction": (context) {
            Navigator.pushNamed(context, transactionListScreen);
          },
          "isResetLabel": false
        },*/
      {
        "icon": "rate_icon",
        "label": StringsRes.lblRateUs,
        "clickFunction": (BuildContext context) {
          launchUrl(
              Uri.parse(Platform.isAndroid
                  ? Constant.playStoreUrl
                  : Constant.appStoreUrl),
              mode: LaunchMode.externalApplication);
        },
      },
/*      {
        "icon": "share_icon",
        "label": StringsRes.lblShareApp,
        "clickFunction": (BuildContext context) {
          String shareAppMessage = StringsRes.lblShareAppMessage;
          if (Platform.isAndroid) {
            shareAppMessage = "$shareAppMessage${Constant.playStoreUrl}";
          } else if (Platform.isIOS) {
            shareAppMessage = "$shareAppMessage${Constant.appStoreUrl}";
          }
          Share.share(shareAppMessage, subject: "Share app");
        },
      }*/
      {
        "icon": "terms_icon",
        "label": StringsRes.lblTermsOfService,
        "clickFunction": (context) {
          Navigator.pushNamed(context, webViewScreen,
              arguments: StringsRes.lblTermsOfService);
        }
      },
      {
        "icon": "privacy_icon",
        "label": StringsRes.lblPrivacyPolicy,
        "clickFunction": (context) {
          Navigator.pushNamed(context, webViewScreen,
              arguments: StringsRes.lblPrivacyPolicy);
        }
      },
      {
        "icon": "logout_icon",
        "label": StringsRes.lblLogout,
        "clickFunction": Constant.session.logoutUser,
        "isResetLabel": false
      },
      {
        "icon": "delete_user_account_icon",
        "label": StringsRes.lblDeleteUserAccount,
        "clickFunction": Constant.session.deleteUserAccount,
        "isResetLabel": false
      },
    ];

    setState(() {});
  }
}

import 'package:egrocer_seller/helper/sessionManager.dart';
import 'package:flutter/material.dart';

enum NetworkStatus { Online, Offline }

class Constant {
  static String hostUrl = "https://egrocer.wrteam.in/";

  static String packageName = "com.wrteam.egrocer.seller";
  static String appStoreUrl = "place_app_store_url_here";
  static String playStoreUrl =
      "https://play.google.com/store/apps/details?id=$packageName";

  static String appStoreId = "app_store_id_here";

  ///Set [appLoginType] value 1 for login only sellers
  ///Set [appLoginType] value 2 for login only delivery boys
  ///Set [appLoginType] value 3 for login sellers and delivery boys both
  static int appLoginType = 3;


  static int defaultDataLoadLimitAtOnce = 20;

  static BorderRadius borderRadius5 = BorderRadius.circular(5);
  static BorderRadius borderRadius7 = BorderRadius.circular(7);
  static BorderRadius borderRadius10 = BorderRadius.circular(10);
  static BorderRadius borderRadius13 = BorderRadius.circular(13);

  static late SessionManager session;

  static int searchHistoryListLimit = 20; // resend otp timer

  // Theme list, This system default names please do not change at all
  static List<String> themeList = ["System default", "Light", "Dark"];

  //supported languages
  //https://developers.google.com/admin-sdk/directory/v1/languages
  static List<String> supportedLanguages = [
    'en',
    'hi',
    'bn',
    'ar',
    'ur',
    'es',
    'fr',
    'pt',
    'ru'
  ];

  static Map languageNames = {
    'en': 'English',
    'hi': 'Hindi',
    'bn': 'Bengali',
    'ar': 'Arabic',
    'ur': 'Urdu',
    'es': 'Spanish',
    'fr': 'French',
    'pt': 'Portuguese',
    'ru': 'Russian'
  };
  static String defaultLangCode = 'en';

  //Order statues codes
  static List<String> orderStatusCode = [
    "1" /*Awaiting Payment*/,
    "2" /*Received*/,
    "3" /*Processed*/,
    "4" /*Shipped*/,
    "5" /*Out For Delivery*/,
    "6" /*Delivered*/,
    "7" /*Cancelled*/,
    "8" /*Returned*/
  ];

  //Order statues icons
  static List<String> orderStatusIcons = [
    "orders_status_all_orders" /*All Orders*/,
    "order_status_payment_pending" /*Awaiting Payment*/,
    "order_status_received" /*Received*/,
    "order_status_processed" /*Processed*/,
    "order_status_shipped" /*Shipped*/,
    "order_status_out_for_delivery" /*Out For Delivery*/,
    "order_status_delivered" /*Delivered*/,
    "order_status_cancelled" /*Cancelled*/,
    "order_status_returned" /*Returned*/
  ];


  // App Settings
  static String currency = "";
  static String currencyCode = "";
  static String currencyDecimalPoint = "";
  static String privacyPolicy = "";
  static String termsConditions = "";
  static String appMode = "";
  static List<String> allPermissions = [];

  static String getAssetsPath(int folder, String filename) {
    //0-image,1-svg,2-language

    String path = "";
    switch (folder) {
      case 0:
        path = "assets/images/$filename";
        break;
      case 1:
        path = "assets/svg/$filename.svg";
        break;
      case 2:
        path = "assets/language/$filename.json";
        break;
    }
    return path;
  }

  //Default padding and margin variables

  static double paddingOrMargin2 = 2.00;
  static double paddingOrMargin3 = 3.00;
  static double paddingOrMargin5 = 5.00;
  static double paddingOrMargin7 = 7.00;
  static double paddingOrMargin8 = 8.00;
  static double paddingOrMargin10 = 10.00;
  static double paddingOrMargin12 = 12.00;
  static double paddingOrMargin14 = 14.00;
  static double paddingOrMargin15 = 15.00;
  static double paddingOrMargin18 = 18.00;
  static double paddingOrMargin20 = 20.00;
  static double paddingOrMargin25 = 20.00;
  static double paddingOrMargin30 = 30.00;
  static double paddingOrMargin40 = 40.00;

  static Future<String> getGetMethodUrlWithParams(
      String mainUrl, Map params) async {
    if (params.isNotEmpty) {
      mainUrl = "$mainUrl?";
      for (int i = 0; i < params.length; i++) {
        mainUrl =
            "$mainUrl${i == 0 ? "" : "&"}${params.keys.toList()[i]}=${params.values.toList()[i]}";
      }
    }

    return mainUrl;
  }
}

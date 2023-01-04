import 'dart:convert';

import 'package:egrocer_seller/helper/utils/constant.dart';
import 'package:egrocer_seller/helper/utils/generalMethods.dart';
import 'package:egrocer_seller/helper/utils/stringsRes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

//

//For localization of app
class AppLocalization {
  final Locale locale;

  //it will hold key of text and it's values in given language
  // late Map<String, String> _localizedValues;
  late Map<String, dynamic> localizedValues;

  AppLocalization(this.locale);

  //to access applocalization instance any where in app using context
  static AppLocalization? of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  //to load json(language) from assets
  Future loadJson() async {
    String languageJsonName = locale.countryCode == null
        ? locale.languageCode
        : "${locale.languageCode}-${locale.countryCode}";
    String jsonStringValues = await rootBundle.loadString(
      Constant.getAssetsPath(2, languageJsonName),
    );
    //value from rootbundle will be encoded string
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    localizedValues = mappedJson;

    translateLabels(mappedJson);
  }



  static translateLabels(Map localizedValues) {
    if (localizedValues.isNotEmpty) {
      StringsRes.appName = localizedValues['appName'] ?? StringsRes.appName;
      StringsRes.lblEmail = localizedValues['lblEmail'] ?? StringsRes.lblEmail;
      StringsRes.lblPassword = localizedValues['lblPassword'] ?? StringsRes.lblPassword;
      StringsRes.lblEnterValidEmail = localizedValues['lblEnterValidEmail'] ?? StringsRes.lblEnterValidEmail;
      StringsRes.lblEnterValidPassword = localizedValues['lblEnterValidPassword'] ?? StringsRes.lblEnterValidPassword;
      StringsRes.lblLogin = localizedValues['lblLogin'] ?? StringsRes.lblLogin;
      StringsRes.lblLoginTypePageTitle = localizedValues['lblLoginTypePageTitle'] ?? StringsRes.lblLoginTypePageTitle;
      StringsRes.lblLoginTypePageDescription = localizedValues['lblLoginTypePageDescription'] ?? StringsRes.lblLoginTypePageDescription;
      StringsRes.lblLoginAs = localizedValues['lblLoginAs'] ?? StringsRes.lblLoginAs;
      StringsRes.lblSeller = localizedValues['lblSeller'] ?? StringsRes.lblSeller;
      StringsRes.lblDeliveryBoy = localizedValues['lblDeliveryBoy'] ?? StringsRes.lblDeliveryBoy;
      StringsRes.lblAgreementMsg1 = localizedValues['lblAgreementMsg1'] ?? StringsRes.lblAgreementMsg1;
      StringsRes.lblAnd = localizedValues['lblAnd'] ?? StringsRes.lblAnd;
      StringsRes.lblTermsOfService = localizedValues['lblTermsOfService'] ?? StringsRes.lblTermsOfService;
      StringsRes.lblPrivacyPolicy = localizedValues['lblPrivacyPolicy'] ?? StringsRes.lblPrivacyPolicy;
      StringsRes.lblAcceptTermsConditionMessage = localizedValues['lblAcceptTermsConditionMessage'] ?? StringsRes.lblAcceptTermsConditionMessage;
      StringsRes.lblChangeTheme = localizedValues['lblChangeTheme'] ?? StringsRes.lblChangeTheme;
      StringsRes.lblChangeLanguage = localizedValues['lblChangeLanguage'] ?? StringsRes.lblChangeLanguage;
      StringsRes.lblOutOfStock = localizedValues['lblOutOfStock'] ?? StringsRes.lblOutOfStock;
      StringsRes.lblLogoutTitle = localizedValues['lblLogoutTitle'] ?? StringsRes.lblLogoutTitle;
      StringsRes.lblLogoutMessage = localizedValues['lblLogoutMessage'] ?? StringsRes.lblLogoutMessage;
      StringsRes.lblDeleteUserAccount = localizedValues['lblDeleteUserAccount'] ?? StringsRes.lblDeleteUserAccount;
      StringsRes.lblDeleteUserTitle = localizedValues['lblDeleteUserTitle'] ?? StringsRes.lblDeleteUserTitle;
      StringsRes.lblDeleteUserMessage = localizedValues['lblDeleteUserMessage'] ?? StringsRes.lblDeleteUserMessage;
      StringsRes.lblOk = localizedValues['lblOk'] ?? StringsRes.lblOk;
      StringsRes.lblCancel = localizedValues['lblCancel'] ?? StringsRes.lblCancel;
      StringsRes.lblSomethingWentWrong = localizedValues['lblSomethingWentWrong'] ?? StringsRes.lblSomethingWentWrong;
      StringsRes.lblCheckInternet = localizedValues['lblCheckInternet'] ?? StringsRes.lblCheckInternet;
      StringsRes.lblOrders = localizedValues['lblOrders'] ?? StringsRes.lblOrders;
      StringsRes.lblProducts = localizedValues['lblProducts'] ?? StringsRes.lblProducts;
      StringsRes.lblBalance = localizedValues['lblBalance'] ?? StringsRes.lblBalance;
      StringsRes.lblSoldOutProducts = localizedValues['lblSoldOutProducts'] ?? StringsRes.lblSoldOutProducts;
      StringsRes.lblLowStockProducts = localizedValues['lblLowStockProducts'] ?? StringsRes.lblLowStockProducts;
      StringsRes.lblTitleDashboard = localizedValues['lblTitleDashboard'] ?? StringsRes.lblTitleDashboard;
      StringsRes.lblTitleOrders = localizedValues['lblTitleOrders'] ?? StringsRes.lblTitleOrders;
      StringsRes.lblTitleOrder = localizedValues['lblTitleOrder'] ?? StringsRes.lblTitleOrder;
      StringsRes.lblTitleCategories = localizedValues['lblTitleCategories'] ?? StringsRes.lblTitleCategories;
      StringsRes.lblTitleProfile = localizedValues['lblTitleProfile'] ?? StringsRes.lblTitleProfile;
      StringsRes.lblTitleWeeklySales = localizedValues['lblTitleWeeklySales'] ?? StringsRes.lblTitleWeeklySales;
      StringsRes.lblTitleProductWiseCategoryCount = localizedValues['lblTitleProductWiseCategoryCount'] ?? StringsRes.lblTitleProductWiseCategoryCount;
      StringsRes.lblDescriptionWeeklySales = localizedValues['lblDescriptionWeeklySales'] ?? StringsRes.lblDescriptionWeeklySales;
      StringsRes.lblLogout = localizedValues['lblLogout'] ?? StringsRes.lblLogout;
      StringsRes.lblRateUs = localizedValues['lblRateUs'] ?? StringsRes.lblRateUs;
      StringsRes.lblUserName = localizedValues['lblUserName'] ?? StringsRes.lblUserName;
      StringsRes.lblUserEmail = localizedValues['lblUserEmail'] ?? StringsRes.lblUserEmail;
      StringsRes.lblUserMobile = localizedValues['lblUserMobile'] ?? StringsRes.lblUserMobile;
      StringsRes.lblOrderNote = localizedValues['lblOrderNote'] ?? StringsRes.lblOrderNote;
      StringsRes.lblEnterUserName = localizedValues['lblEnterUserName'] ?? StringsRes.lblEnterUserName;
      StringsRes.lblMobileNumber = localizedValues['lblMobileNumber'] ?? StringsRes.lblMobileNumber;
      StringsRes.lblEnterValidMobile = localizedValues['lblEnterValidMobile'] ?? StringsRes.lblEnterValidMobile;
      StringsRes.lblId = localizedValues['lblId'] ?? StringsRes.lblId;
      StringsRes.lblDeliveryTime = localizedValues['lblDeliveryTime'] ?? StringsRes.lblDeliveryTime;
      StringsRes.lblOrderDate = localizedValues['lblOrderDate'] ?? StringsRes.lblOrderDate;
      StringsRes.lblAddress = localizedValues['lblAddress'] ?? StringsRes.lblAddress;
      StringsRes.lblDeliveryCharge = localizedValues['lblDeliveryCharge'] ?? StringsRes.lblDeliveryCharge;
      StringsRes.lblPayableAmount = localizedValues['lblPayableAmount'] ?? StringsRes.lblPayableAmount;
      StringsRes.lblTotalItemsAmount = localizedValues['lblTotalItemsAmount'] ?? StringsRes.lblTotalItemsAmount;
      StringsRes.lblNotAssign = localizedValues['lblNotAssign'] ?? StringsRes.lblNotAssign;
      StringsRes.lblAmount = localizedValues['lblAmount'] ?? StringsRes.lblAmount;
      StringsRes.lblPaymentMethod = localizedValues['lblPaymentMethod'] ?? StringsRes.lblPaymentMethod;
      StringsRes.lblStatus = localizedValues['lblStatus'] ?? StringsRes.lblStatus;
      StringsRes.lblAll = localizedValues['lblAll'] ?? StringsRes.lblAll;
      StringsRes.lblUpdateOrderStatus = localizedValues['lblUpdateOrderStatus'] ?? StringsRes.lblUpdateOrderStatus;
      StringsRes.lblUpdateDeliveryBoy = localizedValues['lblUpdateDeliveryBoy'] ?? StringsRes.lblUpdateDeliveryBoy;
      StringsRes.lblPendingOrders = localizedValues['lblPendingOrders'] ?? StringsRes.lblPendingOrders;
      StringsRes.lblName = localizedValues['lblName'] ?? StringsRes.lblName;
      StringsRes.lblVariant = localizedValues['lblVariant'] ?? StringsRes.lblVariant;
      StringsRes.lblQuantity = localizedValues['lblQuantity'] ?? StringsRes.lblQuantity;
      StringsRes.lblPrice = localizedValues['lblPrice'] ?? StringsRes.lblPrice;
      StringsRes.lblTax = localizedValues['lblTax'] ?? StringsRes.lblTax;
      StringsRes.lblSubtotal = localizedValues['lblSubtotal'] ?? StringsRes.lblSubtotal;
      StringsRes.lblListOfOrderItems = localizedValues['lblListOfOrderItems'] ?? StringsRes.lblListOfOrderItems;
      StringsRes.lblOrderDetails = localizedValues['lblOrderDetails'] ?? StringsRes.lblOrderDetails;
      StringsRes.lblBillingDetails = localizedValues['lblBillingDetails'] ?? StringsRes.lblBillingDetails;
      StringsRes.lblHomeBottomMenu = localizedValues['lblHomeBottomMenu'] ?? StringsRes.lblHomeBottomMenu;
      StringsRes.lblOrderStatusDisplayNames = localizedValues['lblOrderStatusDisplayNames'] ?? StringsRes.lblOrderStatusDisplayNames;
      StringsRes.lblThemeDisplayNames = localizedValues['lblThemeDisplayNames'] ?? StringsRes.lblThemeDisplayNames;
    }
  }

  //to get translated value of given title/key
  getTranslatedValues(String? key) {
    return localizedValues[key] ?? key;
  }

  //need to declare custom delegate
  static LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();
}

//Custom app delegate
class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  _AppLocalizationDelegate();

  //providing all supporated languages
  @override
  bool isSupported(Locale locale) {
    return GeneralMethods.langList().contains(locale);
  }

  //load languageCode.json files
  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale);
    await localization.loadJson();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}

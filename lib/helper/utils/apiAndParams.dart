import 'package:egrocer_seller/helper/utils/constant.dart';

class ApiAndParams {
  //============== api ===========
  static String apiLogin = "${Constant.hostUrl}api/login";
  static String apiDashboard = "dashboard";
  static String apiCategories = "categories";
  static String apiDeliveryBoys = "delivery_boys";
  static String apiAppSettings = "settings";
  static String apiOrdersHistory = "orders";
  static String apiOrderStatuses = "order_statuses";
  static String apiUpdateOrderStatus = "update_status";
  static String apiUpdateOrderDeliveryBoy = "assign_delivery_boy";
  static String apiOrderById = "order_by_id";

  //============ api params ============

  //General params
  static String status = "status";
  static String message = "message";
  static String limit = "limit";
  static String offset = "offset";
  static String total = "total";

  //Login api params
  static String email = "email";
  static String password = "password";
  static String fcmToken = "fcm_token";
  static String type = "type";

  //Category api params
  static String categoryId = "category_id";

  //Order update api params
  static String orderId = "order_id";
  static String statusId = "status_id";
  static String deliveryBoyId = "delivery_boy_id";

  //App Settings api params
  static String currency = "currency";
  static String currencyCode = "currency_code";
  static String currencyDecimalPoint = "decimal_point";
  static String appMode = "app_mode_seller";
  static String privacyPolicy = "privacy_policy_seller";
  static String termsCondition = "terms_conditions_seller";
  static String allPermissions = "allPermissions";
}

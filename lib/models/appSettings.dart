class AppSettings {
  AppSettings({
    required this.status,
    required this.message,
    required this.total,
    required this.data,
  });

  late final int status;
  late final String message;
  late final int total;
  late final Data data;

  AppSettings.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['total'] = total;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    this.currency,
    this.currencyCode,
    this.decimalPoint,
    this.appModeSeller,
    this.privacyPolicySeller,
    this.termsConditionsSeller,
    this.allPermissions,
  });

  late final String? currency;
  late final String? currencyCode;
  late final String? decimalPoint;
  late final String? appModeSeller;
  late final String? privacyPolicySeller;
  late final String? termsConditionsSeller;
  late final List<String>? allPermissions;

  Data.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    currencyCode = json['currency_code'];
    decimalPoint = json['decimal_point'];
    appModeSeller = json['app_mode_seller'];
    privacyPolicySeller = json['privacy_policy_seller'];
    termsConditionsSeller = json['terms_conditions_seller'];
    allPermissions = List.castFrom<dynamic, String>(json['allPermissions']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['currency'] = currency;
    _data['currency_code'] = currencyCode;
    _data['decimal_point'] = decimalPoint;
    _data['app_mode_seller'] = appModeSeller;
    _data['privacy_policy_seller'] = privacyPolicySeller;
    _data['terms_conditions_seller'] = termsConditionsSeller;
    _data['allPermissions'] = allPermissions;
    return _data;
  }
}

class SellerLogin {
  SellerLogin({
    this.status,
    this.message,
    this.data,
  });

  late final String? status;
  late final String? message;
  late final Data? data;

  SellerLogin.fromJson(Map<String?, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    data = Data.fromJson(json['data']);
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data?.toJson();
    return _data;
  }
}

class Data {
  Data({
    this.user,
    this.accessToken,
  });

  late final User? user;
  late final String? accessToken;

  Data.fromJson(Map<String?, dynamic> json) {
    user = User.fromJson(json['user']);
    accessToken = json['access_token'].toString();
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['user'] = user?.toJson();
    _data['access_token'] = accessToken;
    return _data;
  }
}

class User {
  User({
    this.seller,
  });

  late final Seller? seller;

  User.fromJson(Map<String?, dynamic> json) {
    seller = Seller.fromJson(json['seller']);
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['seller'] = seller?.toJson();
    return _data;
  }
}

class Seller {
  Seller({
    this.id,
    this.name,
    this.storeName,
    this.email,
    this.mobile,
    this.balance,
    this.storeUrl,
    this.storeDescription,
    this.street,
    this.state,
    this.categories,
    this.accountNumber,
    this.bankIfscCode,
    this.accountName,
    this.bankName,
    this.commission,
    this.status,
    this.requireProductsApproval,
    this.nationalIdentityCard,
    this.addressProof,
    this.panNumber,
    this.taxName,
    this.taxNumber,
    this.customerPrivacy,
    this.latitude,
    this.longitude,
    this.placeName,
    this.formattedAddress,
    this.assignDeliveryBoy,
    this.logoUrl,
  });

  late final String? id;
  late final String? name;
  late final String? storeName;
  late final String? email;
  late final String? mobile;
  late final String? balance;
  late final String? storeUrl;
  late final String? storeDescription;
  late final String? street;
  late final String? state;
  late final String? categories;
  late final String? accountNumber;
  late final String? bankIfscCode;
  late final String? accountName;
  late final String? bankName;
  late final String? commission;
  late final String? status;
  late final String? requireProductsApproval;
  late final String? nationalIdentityCard;
  late final String? addressProof;
  late final String? panNumber;
  late final String? taxName;
  late final String? taxNumber;
  late final String? customerPrivacy;
  late final String? latitude;
  late final String? longitude;
  late final String? placeName;
  late final String? formattedAddress;
  late final String? assignDeliveryBoy;
  late final String? logoUrl;

  Seller.fromJson(Map<String?, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    storeName = json['store_name'].toString();
    email = json['email'].toString();
    mobile = json['mobile'].toString();
    balance = json['balance'].toString();
    storeUrl = json['store_url'].toString();
    storeDescription = json['store_description'].toString();
    street = json['street'].toString();
    state = json['state'].toString();
    categories = json['categories'].toString();
    accountNumber = json['account_number'].toString();
    bankIfscCode = json['bank_ifsc_code'].toString();
    accountName = json['account_name'].toString();
    bankName = json['bank_name'].toString();
    commission = json['commission'].toString();
    status = json['status'].toString();
    requireProductsApproval = json['require_products_approval'].toString();
    nationalIdentityCard = json['national_identity_card'].toString();
    addressProof = json['address_proof'].toString();
    panNumber = json['pan_number'].toString();
    taxName = json['tax_name'].toString();
    taxNumber = json['tax_number'].toString();
    customerPrivacy = json['customer_privacy'].toString();
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    placeName = json['place_name'].toString();
    formattedAddress = json['formatted_address'].toString();
    assignDeliveryBoy = json['assign_delivery_boy'].toString();
    logoUrl = json['logo_url'].toString();
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['store_name'] = storeName;
    _data['email'] = email;
    _data['mobile'] = mobile;
    _data['balance'] = balance;
    _data['store_url'] = storeUrl;
    _data['store_description'] = storeDescription;
    _data['street'] = street;
    _data['state'] = state;
    _data['categories'] = categories;
    _data['account_number'] = accountNumber;
    _data['bank_ifsc_code'] = bankIfscCode;
    _data['account_name'] = accountName;
    _data['bank_name'] = bankName;
    _data['commission'] = commission;
    _data['status'] = status;
    _data['require_products_approval'] = requireProductsApproval;
    _data['national_identity_card'] = nationalIdentityCard;
    _data['address_proof'] = addressProof;
    _data['pan_number'] = panNumber;
    _data['tax_name'] = taxName;
    _data['tax_number'] = taxNumber;
    _data['customer_privacy'] = customerPrivacy;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['place_name'] = placeName;
    _data['formatted_address'] = formattedAddress;
    _data['assign_delivery_boy'] = assignDeliveryBoy;
    _data['logo_url'] = logoUrl;
    return _data;
  }
}

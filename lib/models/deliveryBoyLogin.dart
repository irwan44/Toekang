class DeliveryBoyLogin {
  int? status;
  String? message;
  int? total;
  Data? data;

  DeliveryBoyLogin({this.status, this.message, this.total, this.data});

  DeliveryBoyLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String? accessToken;

  Data({this.user, this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['access_token'] = this.accessToken;
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;
  int? roleId;
  int? createdBy;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  List<String>? allPermissions;
  int? sellerStatus;
  int? deliveryBoyStatus;
  Role? role;
  DeliveryBoy? deliveryBoy;

  User(
      {this.id,
        this.username,
        this.email,
        this.roleId,
        this.createdBy,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.allPermissions,
        this.sellerStatus,
        this.deliveryBoyStatus,
        this.role,
        this.deliveryBoy});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    roleId = json['role_id'];
    createdBy = json['created_by'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    allPermissions = json['allPermissions'].cast<String>();
    sellerStatus = json['seller_status'];
    deliveryBoyStatus = json['delivery_boy_status'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    deliveryBoy = json['delivery_boy'] != null
        ? new DeliveryBoy.fromJson(json['delivery_boy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['role_id'] = this.roleId;
    data['created_by'] = this.createdBy;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['allPermissions'] = this.allPermissions;
    data['seller_status'] = this.sellerStatus;
    data['delivery_boy_status'] = this.deliveryBoyStatus;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    if (this.deliveryBoy != null) {
      data['delivery_boy'] = this.deliveryBoy!.toJson();
    }
    return data;
  }
}

class Role {
  int? id;
  String? name;
  String? guardName;

  Role({this.id, this.name, this.guardName});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['guard_name'] = this.guardName;
    return data;
  }
}

class DeliveryBoy {
  int? id;
  int? adminId;
  int? cityId;
  String? name;
  String? mobile;
  String? address;
  int? bonus;
  int? balance;
  String? dob;
  String? bankAccountNumber;
  String? bankName;
  String? accountName;
  String? ifscCode;
  String? otherPaymentInformation;
  int? status;
  int? isAvailable;
  int? cashReceived;
  String? createdAt;
  String? updatedAt;
  int? pendingOrderCount;

  DeliveryBoy(
      {this.id,
        this.adminId,
        this.cityId,
        this.name,
        this.mobile,
        this.address,
        this.bonus,
        this.balance,
        this.dob,
        this.bankAccountNumber,
        this.bankName,
        this.accountName,
        this.ifscCode,
        this.otherPaymentInformation,
        this.status,
        this.isAvailable,
        this.cashReceived,
        this.createdAt,
        this.updatedAt,
        this.pendingOrderCount});

  DeliveryBoy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminId = json['admin_id'];
    cityId = json['city_id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    bonus = json['bonus'];
    balance = json['balance'];
    dob = json['dob'];
    bankAccountNumber = json['bank_account_number'];
    bankName = json['bank_name'];
    accountName = json['account_name'];
    ifscCode = json['ifsc_code'];
    otherPaymentInformation = json['other_payment_information'];
    status = json['status'];
    isAvailable = json['is_available'];
    cashReceived = json['cash_received'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pendingOrderCount = json['pending_order_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['admin_id'] = this.adminId;
    data['city_id'] = this.cityId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['bonus'] = this.bonus;
    data['balance'] = this.balance;
    data['dob'] = this.dob;
    data['bank_account_number'] = this.bankAccountNumber;
    data['bank_name'] = this.bankName;
    data['account_name'] = this.accountName;
    data['ifsc_code'] = this.ifscCode;
    data['other_payment_information'] = this.otherPaymentInformation;
    data['status'] = this.status;
    data['is_available'] = this.isAvailable;
    data['cash_received'] = this.cashReceived;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pending_order_count'] = this.pendingOrderCount;
    return data;
  }
}

class DeliveryBoyOrder {
  DeliveryBoyOrder({
    this.status,
    this.message,
    this.total,
    this.data,
  });

  late final int? status;
  late final String? message;
  late final int? total;
  late final Data? data;

  DeliveryBoyOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    message = json['message'] ?? "";
    total = json['total'] ?? 0;
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['total'] = total;
    _data['data'] = data?.toJson();
    return _data;
  }
}

class Data {
  Data({
    this.orders,
  });

  late final List<DeliveryBoyOrdersListItem>? orders;

  Data.fromJson(Map<String, dynamic> json) {
    orders = List.from(json['orders'])
        .map(
          (e) => DeliveryBoyOrdersListItem.fromJson(e),
        )
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['orders'] = orders
        ?.map(
          (e) => e.toJson(),
        )
        .toList();
    return _data;
  }
}

class StatusOrderCount {
  StatusOrderCount({
    this.id,
    this.status,
    this.orderCount,
  });

  late final int? id;
  late final String? status;
  late final int? orderCount;

  StatusOrderCount.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    status = json['status'] ?? "";
    orderCount = json['order_count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['status'] = status;
    _data['order_count'] = orderCount;
    return _data;
  }
}

class DeliveryBoyOrdersListItem {
  DeliveryBoyOrdersListItem({
    this.id,
    this.deliveryBoyId,
    this.orderId,
    this.mobile,
    this.orderNote,
    this.total,
    this.deliveryCharge,
    this.taxAmount,
    this.taxPercentage,
    this.discount,
    this.finalTotal,
    this.paymentMethod,
    this.address,
    this.latitude,
    this.longitude,
    this.deliveryTime,
    this.activeStatus,
    this.pincodeId,
    this.addressId,
    this.createdAt,
    this.deliveryBoyName,
    this.userName,
    this.orderStatus,
  });

  late final int? id;
  late final int? deliveryBoyId;
  late final String? orderId;
  late final String? mobile;
  late final String? orderNote;
  late final double? total;
  late final double? deliveryCharge;
  late final double? taxAmount;
  late final double? taxPercentage;
  late final double? discount;
  late final double? finalTotal;
  late final String? paymentMethod;
  late final String? address;
  late final String? latitude;
  late final String? longitude;
  late final String? deliveryTime;
  late final String? activeStatus;
  late final String? pincodeId;
  late final int? addressId;
  late final String? createdAt;
  late final String? deliveryBoyName;
  late final String? userName;
  late final String? orderStatus;

  DeliveryBoyOrdersListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    deliveryBoyId = json['delivery_boy_id'] ?? 0;
    orderId = json['order_id'].toString();
    mobile = json['mobile'] ?? "";
    orderNote = json['order_note'] ?? "";
    total = double.parse(
      json['total'].toString(),
    );
    deliveryCharge = double.parse(
      json['delivery_charge'].toString(),
    );
    taxAmount = double.parse(
      json['tax_amount'].toString(),
    );
    taxPercentage = double.parse(
      json['tax_percentage'].toString(),
    );
    discount = double.parse(
      json['discount'].toString(),
    );
    finalTotal = double.parse(
      json['final_total'].toString(),
    );
    paymentMethod = json['payment_method'] ?? "";
    address = json['address'] ?? "";
    latitude = json['latitude'] ?? "";
    longitude = json['longitude'] ?? "";
    deliveryTime = json['delivery_time'] ?? "";
    activeStatus = json['active_status'] ?? "";
    addressId = json['address_id'] ?? 0;
    createdAt = json['created_at'] ?? "";
    deliveryBoyName = json['delivery_boy_name'] ?? "";
    userName = json['user_name'] ?? "";
    orderStatus = json['order_status'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['delivery_boy_id'] = deliveryBoyId;
    _data['order_id'] = orderId;
    _data['mobile'] = mobile;
    _data['order_note'] = orderNote;
    _data['total'] = total;
    _data['delivery_charge'] = deliveryCharge;
    _data['tax_amount'] = taxAmount;
    _data['tax_percentage'] = taxPercentage;
    _data['discount'] = discount;
    _data['final_total'] = finalTotal;
    _data['payment_method'] = paymentMethod;
    _data['address'] = address;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['delivery_time'] = deliveryTime;
    _data['active_status'] = activeStatus;
    _data['pincode_id'] = pincodeId;
    _data['address_id'] = addressId;
    _data['created_at'] = createdAt;
    _data['delivery_boy_name'] = deliveryBoyName;
    _data['user_name'] = userName;
    _data['order_status'] = orderStatus;
    return _data;
  }
}

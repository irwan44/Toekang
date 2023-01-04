class OrderDetail {
  int? status;
  String? message;
  int? total;
  Data? data;

  OrderDetail({this.status, this.message, this.total, this.data});

  OrderDetail.fromJson(Map<String, dynamic> json) {
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
  Order? order;
  List<OrderItems>? orderItems;

  Data({this.order, this.orderItems});

  Data.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(
          new OrderItems.fromJson(v),
        );
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.orderItems != null) {
      data['order_items'] = this
          .orderItems!
          .map(
            (v) => v.toJson(),
          )
          .toList();
    }
    return data;
  }
}

class Order {
  int? id;
  int? userId;
  int? deliveryBoyId;
  String? transactionId;
  String? mobile;
  String? orderNote;
  double? total;
  double? deliveryCharge;
  double? discount;
  double? promoDiscount;
  double? finalTotal;
  String? paymentMethod;
  String? address;
  String? latitude;
  String? longitude;
  String? deliveryTime;
  String? activeStatus;
  String? orderDate;
  int? orderId;
  String? type;
  String? userName;
  String? userEmail;
  String? alternateMobile;
  String? landmark;
  String? area;
  String? pincode;
  String? city;
  String? state;
  String? country;
  String? street;
  int? customerPrivacy;
  String? deliveryBoyName;

  Order(
      {this.id,
      this.userId,
      this.deliveryBoyId,
      this.transactionId,
      this.mobile,
      this.orderNote,
      this.total,
      this.deliveryCharge,
      this.discount,
      this.promoDiscount,
      this.finalTotal,
      this.paymentMethod,
      this.address,
      this.latitude,
      this.longitude,
      this.deliveryTime,
      this.activeStatus,
      this.orderDate,
      this.orderId,
      this.type,
      this.userName,
      this.userEmail,
      this.alternateMobile,
      this.landmark,
      this.area,
      this.pincode,
      this.city,
      this.state,
      this.country,
      this.street,
      this.customerPrivacy,
      this.deliveryBoyName});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    deliveryBoyId = json['delivery_boy_id'];
    transactionId = json['transaction_id'];
    mobile = json['mobile'];
    orderNote = json['order_note'];
    total = double.parse(
      json['total'].toString(),
    );
    deliveryCharge = double.parse(
      json['delivery_charge'].toString(),
    );
    discount = double.parse(
      json['discount'].toString(),
    );
    promoDiscount = double.parse(
      json['promo_discount'].toString(),
    );
    finalTotal = double.parse(
      json['final_total'].toString(),
    );
    paymentMethod = json['payment_method'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deliveryTime = json['delivery_time'];
    activeStatus = json['active_status'].toString();
    orderDate = json['created_at'].toString();
    orderId = json['order_id'];
    type = json['type'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    alternateMobile = json['alternate_mobile'];
    landmark = json['landmark'];
    area = json['area'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    street = json['street'];
    customerPrivacy = json['customer_privacy'];
    deliveryBoyName = json['delivery_boy_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['delivery_boy_id'] = this.deliveryBoyId;
    data['transaction_id'] = this.transactionId;
    data['mobile'] = this.mobile;
    data['order_note'] = this.orderNote;
    data['total'] = this.total;
    data['delivery_charge'] = this.deliveryCharge;
    data['discount'] = this.discount;
    data['promo_discount'] = this.promoDiscount;
    data['final_total'] = this.finalTotal;
    data['payment_method'] = this.paymentMethod;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['delivery_time'] = this.deliveryTime;
    data['active_status'] = this.activeStatus;
    data['created_at'] = this.orderDate;
    data['order_id'] = this.orderId;
    data['type'] = this.type;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['alternate_mobile'] = this.alternateMobile;
    data['landmark'] = this.landmark;
    data['area'] = this.area;
    data['pincode'] = this.pincode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['street'] = this.street;
    data['customer_privacy'] = this.customerPrivacy;
    data['delivery_boy_name'] = this.deliveryBoyName;
    return data;
  }
}

class OrderItems {
  int? orderId;
  String? productName;
  String? variantName;
  int? deliveryBoyId;
  int? quantity;
  double? price;
  double? discountedPrice;
  double? taxAmount;
  double? taxPercentage;
  double? subTotal;
  String? mobile;
  double? total;
  double? deliveryCharge;
  double? finalTotal;
  String? paymentMethod;
  String? address;
  String? deliveryTime;
  String? userName;
  int? productId;

  OrderItems(
      {this.orderId,
      this.productName,
      this.variantName,
      this.deliveryBoyId,
      this.quantity,
      this.price,
      this.discountedPrice,
      this.taxAmount,
      this.taxPercentage,
      this.subTotal,
      this.mobile,
      this.total,
      this.deliveryCharge,
      this.finalTotal,
      this.paymentMethod,
      this.address,
      this.deliveryTime,
      this.userName,
      this.productId});

  OrderItems.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productName = json['product_name'];
    variantName = json['variant_name'];
    deliveryBoyId = json['delivery_boy_id'];
    quantity = json['quantity'];
    price = double.parse(
      json['price'].toString(),
    );
    discountedPrice = double.parse(
      json['discounted_price'].toString(),
    );
    taxAmount = double.parse(
      json['tax_amount'].toString(),
    );
    taxPercentage = double.parse(
      json['tax_percentage'].toString(),
    );
    subTotal = double.parse(
      json['sub_total'].toString(),
    );
    mobile = json['mobile'];
    total = double.parse(
      json['total'].toString(),
    );
    deliveryCharge = double.parse(
      json['delivery_charge'].toString(),
    );
    finalTotal = double.parse(
      json['final_total'].toString(),
    );
    paymentMethod = json['payment_method'];
    address = json['address'];
    deliveryTime = json['delivery_time'];
    userName = json['user_name'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['product_name'] = this.productName;
    data['variant_name'] = this.variantName;
    data['delivery_boy_id'] = this.deliveryBoyId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['discounted_price'] = this.discountedPrice;
    data['tax_amount'] = this.taxAmount;
    data['tax_percentage'] = this.taxPercentage;
    data['sub_total'] = this.subTotal;
    data['mobile'] = this.mobile;
    data['total'] = this.total;
    data['delivery_charge'] = this.deliveryCharge;
    data['final_total'] = this.finalTotal;
    data['payment_method'] = this.paymentMethod;
    data['address'] = this.address;
    data['delivery_time'] = this.deliveryTime;
    data['user_name'] = this.userName;
    data['product_id'] = this.productId;
    return data;
  }
}

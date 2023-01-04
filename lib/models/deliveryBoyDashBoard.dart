class DeliveryBoyDashBoard {
  int? status;
  String? message;
  int? total;
  Data? data;

  DeliveryBoyDashBoard({this.status, this.message, this.total, this.data});

  DeliveryBoyDashBoard.fromJson(Map<String, dynamic> json) {
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
  int? orderCount;
  double? balance;

  Data({this.orderCount, this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    orderCount = json['order_count'];
    balance = double.parse(
      json['balance'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_count'] = this.orderCount;
    data['balance'] = this.balance;
    return data;
  }
}

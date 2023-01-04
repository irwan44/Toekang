class OrderStatuses {
  int? status;
  String? message;
  int? total;
  List<OrderStatusesData>? data;

  OrderStatuses({this.status, this.message, this.total, this.data});

  OrderStatuses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <OrderStatusesData>[];
      json['data'].forEach((v) {
        data!.add(
          new OrderStatusesData.fromJson(v),
        );
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this
          .data!
          .map(
            (v) => v.toJson(),
          )
          .toList();
    }
    return data;
  }
}

class OrderStatusesData {
  int? id;
  String? status;

  OrderStatusesData({this.id, this.status});

  OrderStatusesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    return data;
  }
}

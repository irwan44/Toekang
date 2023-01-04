class DeliveryBoys {
  int? status;
  String? message;
  int? total;
  List<DeliveryBoysData>? data;

  DeliveryBoys({this.status, this.message, this.total, this.data});

  DeliveryBoys.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <DeliveryBoysData>[];
      json['data'].forEach((v) {
        data!.add(
          new DeliveryBoysData.fromJson(v),
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

class DeliveryBoysData {
  int? id;
  String? name;
  int? pendingOrderCount;

  DeliveryBoysData({this.id, this.name, this.pendingOrderCount});

  DeliveryBoysData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pendingOrderCount = json['pending_order_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pending_order_count'] = this.pendingOrderCount;
    return data;
  }
}

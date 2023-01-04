class SellerDashBoard {
  SellerDashBoard({
    this.status,
    this.message,
    this.total,
    this.data,
  });

  late final int? status;
  late final String? message;
  late final double? total;
  late final Data? data;

  SellerDashBoard.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = double.parse(
      json['total'].toString(),
    );
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
    this.orderCount,
    this.productCount,
    this.categoryCount,
    this.soldOutCount,
    this.lowStockCount,
    this.balance,
    this.categoryProductCount,
    this.weeklySales,
    this.statusOrderCount,
  });

  late final int? orderCount;
  late final int? productCount;
  late final int? categoryCount;
  late final int? soldOutCount;
  late final int? lowStockCount;
  late final double? balance;
  late final List<CategoryProductCount>? categoryProductCount;
  late final List<WeeklySales>? weeklySales;
  late final List<StatusOrderCount>? statusOrderCount;

  Data.fromJson(Map<String, dynamic> json) {
    orderCount = int.parse(
      json['order_count'].toString(),
    );
    productCount = int.parse(
      json['product_count'].toString(),
    );
    categoryCount = int.parse(
      json['category_count'].toString(),
    );
    soldOutCount = int.parse(
      json['sold_out_count'].toString(),
    );
    lowStockCount = int.parse(
      json['low_stock_count'].toString(),
    );
    balance = double.parse(
      json['balance'].toString(),
    );
    categoryProductCount = List.from(json['category_product_count'])
        .map(
          (e) => CategoryProductCount.fromJson(e),
        )
        .toList();
    weeklySales = List.from(json['weekly_sales'])
        .map(
          (e) => WeeklySales.fromJson(e),
        )
        .toList();
    statusOrderCount = List.from(json['status_order_count'])
        .map(
          (e) => StatusOrderCount.fromJson(e),
        )
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order_count'] = orderCount;
    _data['product_count'] = productCount;
    _data['category_count'] = categoryCount;
    _data['sold_out_count'] = soldOutCount;
    _data['low_stock_count'] = lowStockCount;
    _data['balance'] = balance;
    _data['category_product_count'] = categoryProductCount
        ?.map(
          (e) => e.toJson(),
        )
        .toList();
    _data['weekly_sales'] = weeklySales
        ?.map(
          (e) => e.toJson(),
        )
        .toList();
    _data['status_order_count'] = statusOrderCount
        ?.map(
          (e) => e.toJson(),
        )
        .toList();
    return _data;
  }
}

class CategoryProductCount {
  CategoryProductCount({
    this.id,
    this.name,
    this.productCount,
  });

  late final int? id;
  late final String? name;
  late final double? productCount;

  CategoryProductCount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productCount = double.parse(
      json['product_count'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['product_count'] = productCount;
    return _data;
  }
}

class WeeklySales {
  WeeklySales({
    this.totalSale,
    this.orderDate,
  });

  late final double? totalSale;
  late final String? orderDate;

  WeeklySales.fromJson(Map<String, dynamic> json) {
    totalSale = double.parse(
      json['total_sale'].toString(),
    );
    orderDate = json['order_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total_sale'] = totalSale;
    _data['order_date'] = orderDate;
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
  late final double? orderCount;

  StatusOrderCount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    orderCount = double.parse(
      json['order_count'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['status'] = status;
    _data['order_count'] = orderCount;
    return _data;
  }
}

class Category {
  int? status;
  String? message;
  int? total;
  List<CategoryData>? data;

  Category({this.status, this.message, this.total, this.data});

  Category.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(
          new CategoryData.fromJson(v),
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

class CategoryData {
  int? id;
  String? name;
  int? parentId;
  String? imageUrl;
  bool? hasChild;

  CategoryData(
      {this.id, this.name, this.parentId, this.imageUrl, this.hasChild});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    parentId = json['parent_id'] ?? 0;
    imageUrl = json['image_url'] ?? "";
    hasChild = json['has_child'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['image_url'] = this.imageUrl;
    data['has_child'] = this.hasChild;
    return data;
  }
}

class HomeResponseModel {
  HomeResponseModel({
      this.type, 
      this.data, 
      this.subtype,});

  HomeResponseModel.fromJson(dynamic json) {
    type = json['type'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    subtype = json['subtype'];
  }
  String? type;
  Data? data;
  String? subtype;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['subtype'] = subtype;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.title, 
      this.items,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  String? id;
  String? title;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Items {
  Items({
      this.name, 
      this.id, 
      this.sku, 
      this.image, 
      this.price, 
      this.storage, 
      this.productTag, 
      this.preorder,});

  Items.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
    sku = json['sku'];
    image = json['image'];
    price = json['price'];
    storage = json['storage'];
    productTag = json['product_tag'];
    preorder = json['preorder'];
  }
  String? name;
  String? id;
  String? sku;
  String? image;
  double? price;
  String? storage;
  dynamic productTag;
  String? preorder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;
    map['sku'] = sku;
    map['image'] = image;
    map['price'] = price;
    map['storage'] = storage;
    map['product_tag'] = productTag;
    map['preorder'] = preorder;
    return map;
  }

}
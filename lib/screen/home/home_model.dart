// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

List<HomeModel> homeModelFromJson(String str) => List<HomeModel>.from(json.decode(str).map((x) => HomeModel.fromJson(x)));

String homeModelToJson(List<HomeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeModel {
  HomeModel({
    this.type,
    this.data,
    this.subtype,
  });

  String? type;
  Data? data;
  String? subtype;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    type: json["type"],
    data: Data.fromJson(json["data"]),
    subtype: json["subtype"] == null ? null : json["subtype"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "data": data?.toJson(),
    "subtype": subtype == null ? null : subtype,
  };
}

class Data {
  Data({
    this.id,
    this.title,
    this.items,
    this.type,
    this.file,
  });

  String? id;
  String? title;
  List<Item>? items;
  String? type;
  String? file;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"] == null ? null : json["title"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    type: json["type"] == null ? null : json["type"],
    file: json["file"] == null ? null : json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title == null ? null : title,
    "items":List<Item>.from(items!.map((x) => x.toJson())),
    "type": type == null ? null : type,
    "file": file == null ? null : file,
  };
}

class Item {
  Item({
    this.name,
    this.id,
    this.sku,
    this.image,
    this.price,
    this.storage,
    this.productTag,
    this.preorder,
  });

  String? name;
  String? id;
  String? sku;
  String? image;
  double? price;
  dynamic storage;
  ProductTag? productTag;
  String? preorder;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json["name"],
    id: json["id"],
    sku: json["sku"],
    image: json["image"],
    price: json["price"].toDouble(),
    storage: json["storage"],
    productTag: json["product_tag"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "sku": sku,
    "image": image,
    "price": price,
    "storage": storage,
    "product_tag": productTag,
    "preorder": preorder,
  };
}

enum ProductTag { VAT_INCLUDED }

// final productTagValues = EnumValues({
//   "Vat included": ProductTag.VAT_INCLUDED
// });

enum StorageEnum { THE_32_GB, THE_128_GB, THE_256_GB }

// final storageEnumValues = EnumValues({
//   "128 GB": StorageEnum.THE_128_GB,
//   "256 GB": StorageEnum.THE_256_GB,
//   "32 GB": StorageEnum.THE_32_GB
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }

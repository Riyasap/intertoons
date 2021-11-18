import 'package:equatable/equatable.dart';

class ProductResponseModel extends Equatable{
  ProductResponseModel({
      this.name, 
      this.id, 
      this.sku, 
      this.evoucher, 
      this.ecard, 
      this.description, 
      this.shortDescription, 
      this.brand, 
      this.image, 
      this.hasOptions, 
      this.productTag, 
      this.preorder, 
      this.price, 
      this.status, 
      this.attrs,
    this.count,
  });

  ProductResponseModel.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
    sku = json['sku'];
    evoucher = json['evoucher'];
    ecard = json['ecard'];
    description = json['description'];
    shortDescription = json['short_description'];
    brand = json['brand'];
    image = json['image'] != null ? json['image'].cast<String>() : [];
    hasOptions = json['has_options'];
    productTag = json['product_tag'];
    preorder = json['preorder'];
    price = json['price'];
    status = json['status'];
    attrs = json['attrs'] != null ? Attrs.fromJson(json['attrs']) : null;
  }
  String? name;
  String? id;
  String? sku;
  int? evoucher;
  int? ecard;
  dynamic description;
  dynamic shortDescription;
  String? brand;
  List<String>? image;
  int? hasOptions;
  dynamic productTag;
  int? preorder;
  double? price;
  int? status;
  Attrs? attrs;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;
    map['sku'] = sku;
    map['evoucher'] = evoucher;
    map['ecard'] = ecard;
    map['description'] = description;
    map['short_description'] = shortDescription;
    map['brand'] = brand;
    map['image'] = image;
    map['has_options'] = hasOptions;
    map['product_tag'] = productTag;
    map['preorder'] = preorder;
    map['price'] = price;
    map['status'] = status;
    if (attrs != null) {
      map['attrs'] = attrs?.toJson();
    }
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class Attrs {
  Attrs({
      this.color, 
      this.specs,});

  Attrs.fromJson(dynamic json) {
    color = json['color'];
    // if (json['specs'] != null) {
    //   specs = [];
    //   json['specs'].forEach((v) {
    //     specs?.add(dynamic.fromJson(v));
    //   });
    // }
  }
  String? color;
  List<dynamic>? specs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['color'] = color;
    if (specs != null) {
      map['specs'] = specs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
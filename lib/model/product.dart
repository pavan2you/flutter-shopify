import 'dart:convert';
import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/model/image.dart';
import 'package:shopify/model/product_option.dart';
import 'package:shopify/model/product_variant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(nullable: false)
class Product extends DataObject with _$ProductSerializerMixin {
  String id;
  String title;
  String productDescription;
  String additionalDescription;
  String currency;
  double price;
  bool hasAlternativePrice;
  String discount;
  String vendor;
  String type;
  String createdAt;
  String updatedAt;
  List<String> tags;
  List<ImageDTO> images;
  List<ProductOption> options;
  List<ProductVariant> variants;
  String paginationValue;

  Product({this.id, this.title, this.productDescription,
    this.additionalDescription, this.currency, this.price,
    this.hasAlternativePrice, this.discount, this.vendor, this.type,
    this.createdAt, this.updatedAt, this.tags, this.images, this.options,
    this.variants, this.paginationValue});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["title"] = title;
    map["productDescription"] = productDescription;
    map["additionalDescription"] = additionalDescription;
    map["currency"] = currency;
    map["price"] = price;
    map["hasAlternativePrice"] = hasAlternativePrice;
    map["discount"] = discount;
    map["vendor"] = vendor;
    map["type"] = type;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    map["tags"] = tags;
    map["images"] = images;
    map["options"] = options;
    map["variants"] = variants;
    map["paginationValue"] = paginationValue;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = id.hashCode;

    result = 31 * result + title.hashCode;
    result = 31 * result + productDescription.hashCode;
    result = 31 * result + additionalDescription.hashCode;
    result = 31 * result + currency.hashCode;
    result = 31 * result + price.hashCode;
    result = 31 * result + hasAlternativePrice.hashCode;
    result = 31 * result + (discount != null ? discount.hashCode : 0);
    result = 31 * result + vendor.hashCode;
    result = 31 * result + type.hashCode;
    result = 31 * result + createdAt.hashCode;
    result = 31 * result + updatedAt.hashCode;
    result = 31 * result + tags.hashCode;
    result = 31 * result + images.hashCode;
    result = 31 * result + options.hashCode;
    result = 31 * result + variants.hashCode;
    result = 31 * result + (paginationValue != null ? paginationValue.hashCode : 0);
    return result;
  }

  @override
  bool operator ==(object) {

    /*if (this == object) {
      return true;
    }*/

    Product product = object;

    if (id != product.id) return false;

    return true;
  }

  String toString() {
    return "Product{ " +
        " id ='" + id + '\'' +
        ", title ='" + title + '\'' +
        ", variants ='" + variants.toString() + "}";
  }
}
import 'dart:convert';

import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/model/image.dart';
import 'package:shopify/model/variant_option.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_variant.g.dart';

@JsonSerializable(nullable: false)
class ProductVariant extends DataObject with _$ProductVariantSerializerMixin  {
  String id;
  String title;
  double price;
  double compareAtPrice;
  bool isAvailable;
  List<VariantOption> selectedOptions;
  ImageDTO image;
  ImageDTO productImage;
  String productId;
  int noOfQuantities;

  ProductVariant({this.id, this.title, this.price, this.compareAtPrice, this.isAvailable,
    this.selectedOptions, this.image, this.productImage, this.productId});

  factory ProductVariant.fromJson(Map<String, dynamic> json) => _$ProductVariantFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["title"] = title;
    map["price"] = price;
    map["compareAtPrice"] = compareAtPrice;
    map["isAvailable"] = isAvailable;
    map["selectedOptions"] = selectedOptions;
    map["image"] = image;
    map["productImage"] = productImage;
    map["productId"] = productId;
    return map;
  }

  @override
  int get hashCode => _getHashCode();

  int _getHashCode() {
    int result = id.hashCode;

    result = 31 * result + title.hashCode;
    result = 31 * result + price.hashCode;
    result = 31 * result + compareAtPrice.hashCode;
    result = 31 * result + isAvailable.hashCode;
    result = 31 * result + selectedOptions.hashCode;
    result = 31 * result + (image != null ? image.hashCode : 0);
    result = 31 * result + (productImage != null ? productImage.hashCode : 0);
    result = 31 * result + productId.hashCode;
    return result;
  }

  @override
  bool operator ==(object) {

    if (this == object) {
      return true;
    }
    if (object == null || toString() != object.toString()) {
      return false;
    }

    ProductVariant productVariant = object;

    if (id != productVariant.id) return false;
    if (title != productVariant.title) return false;
    if (price != productVariant.price)
      return false;
    if (compareAtPrice != productVariant.compareAtPrice)
      return false;
    if (isAvailable != productVariant.isAvailable) return false;
    if (selectedOptions != productVariant.selectedOptions) return false;
    if (image != productVariant?.image) return false;
    if (productImage != productVariant?.productImage) return false;
    if (productId != productVariant.productId) return false;

    return true;
  }

  String toString() {
    return "ProductVariant{ " +
        " id ='" + id + '\'' +
        ", title ='" + title + '\'' +
        ", price ='" + price.toString() + '\'' +
        ", compareAtPrice ='" + compareAtPrice.toString() + '\'' +
        ", productId ='" + productId + '\'' +
        '}';
  }
}
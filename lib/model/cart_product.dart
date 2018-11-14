import 'dart:convert';

import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/model/product_variant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_product.g.dart';

@JsonSerializable(nullable: false)
class CartProduct extends DataObject with _$CartProductSerializerMixin  {
  ProductVariant productVariant;
  String title;
  String currency;
  int quantity;

  CartProduct({this.productVariant, this.title, this.currency, this.quantity});

  factory CartProduct.fromJson(Map<String, dynamic> json) => _$CartProductFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }
  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["title"] = title;
    map["currency"] = currency;
    map["quantity"] = quantity;
    map["productVariant"] = productVariant;
    return map;
  }

  @override
  int get hashCode => _getHashCode();

  int _getHashCode() {
    int result = productVariant.hashCode;

    result = 31 * result + title.hashCode;
    result = 31 * result + currency.hashCode;
    result = 31 * result + quantity.hashCode;
    return result;
  }

  @override
  bool operator ==(object) {

    /*if (this == object) {
      return true;
    }*/
    if (object == null || toString() != object.toString()) {
      return false;
    }

    /*CartProduct cartProduct = object;

    if (productVariant != cartProduct.productVariant) return false;
    if (title != cartProduct.title) return false;
    if (currency != cartProduct.currency)
      return false;
    if (quantity != cartProduct.quantity) return false;*/

    return true;
  }

  String toString() {
    return "CartProduct{ " +
        " title ='" + title + '\'' +
        ", currency ='" + currency + '\'' +
        ", quantity ='" + quantity.toString() + '\'' +
        '}';
  }
}
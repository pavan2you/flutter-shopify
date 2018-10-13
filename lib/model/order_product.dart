import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/model/product_variant.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'order_product.g.dart';

@JsonSerializable(nullable: false)
class OrderProduct extends DataObject with _$OrderProductSerializerMixin {
  String title;
  ProductVariant productVariant;
  int quantity;

  OrderProduct({this.title, this.productVariant, this.quantity});

  factory OrderProduct.fromJson(Map<String, dynamic> json) => _$OrderProductFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map['title'] = title;
    map['productVariant'] = productVariant;
    map['quantity'] = quantity;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = title.hashCode;

    result = 31 * result + (productVariant != null ? productVariant.hashCode : 0);
    result = 31 * result + quantity.hashCode;
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

    OrderProduct orderProduct = object;

    if (title != orderProduct.title) return false;
    if (productVariant != orderProduct?.productVariant) return false;
    if (quantity != orderProduct.quantity)
      return false;

    return true;
  }

  String toString() {
    return "OrderProduct{ " +
        " title ='" + title + '\'' +
        ", quantity ='" + quantity.toString() + '\'' +
        '}';
  }
}
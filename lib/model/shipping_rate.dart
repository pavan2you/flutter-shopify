import 'dart:convert';
import 'package:jvanila_flutter/jvanila.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shipping_rate.g.dart';

@JsonSerializable(nullable: false)
class ShippingRate extends DataObject with _$ShippingRateSerializerMixin {
  String title;
  double price;
  String handle;

  ShippingRate({this.title, this.price, this.handle});

  factory ShippingRate.fromJson(Map<String, dynamic> json) => _$ShippingRateFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map();
    map["title"] = title;
    map["price"] = price;
    map["handle"] = handle;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = title.hashCode;

    result = 31 * result + price.hashCode;
    result = 31 * result + handle.hashCode;
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

    ShippingRate shippingRate = object;

    if (title != shippingRate.title) return false;
    if (price != shippingRate.price) return false;
    if (handle != shippingRate.handle)
      return false;

    return true;
  }

  String toString() {
    return "ShippingRate{ " +
        " title ='" + title + '\'' +
        ", price ='" + price.toString() + '\'' +
        ", handle ='" + handle + '\'' +
        '}';
  }
}
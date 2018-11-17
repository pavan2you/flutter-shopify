import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/model/address.dart';
import 'package:shopify/model/order_product.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'order.g.dart';

@JsonSerializable(nullable: false)
class Order extends DataObject with _$OrderSerializerMixin {
  String id;
  String currency;
  String email;
  //using this for status
  int orderNumber;
  double subtotalPrice;
  double totalShippingPrice;
  double totalPrice;
  DateTime processedAt;
  List<OrderProduct> orderProducts;
  Address address;
  String paginationValue;

  Order({this.id, this.currency, this.email, this.orderNumber,
    this.subtotalPrice, this.totalShippingPrice, this.totalPrice,
    this.processedAt, this.orderProducts, this.address, this.paginationValue});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map();
    map["id"] = id;
    map["currency"] = currency;
    map["email"] = email;
    map["orderNumber"] = orderNumber;
    map["subtotalPrice"] = subtotalPrice;
    map["totalShippingPrice"] = totalShippingPrice;
    map["totalPrice"] = totalPrice;
    map["processedAt"] = processedAt;
    map["orderProducts"] = orderProducts;
    map["address"] = address;
    map["paginationValue"] = paginationValue;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = id.hashCode;

    result = 31 * result + currency.hashCode;
    result = 31 * result + email.hashCode;
    result = 31 * result + orderNumber.hashCode;
    result = 31 * result + (subtotalPrice != null ? subtotalPrice.hashCode : 0);
    result = 31 * result + (totalShippingPrice != null ? totalShippingPrice.hashCode : 0);
    result = 31 * result + totalPrice.hashCode;
    result = 31 * result + processedAt.hashCode;
    result = 31 * result + orderProducts.hashCode;
    result = 31 * result + (address != null ? address.hashCode : 0);
    result = 31 * result + (paginationValue != null ? paginationValue.hashCode : 0);
    return result;
  }

  @override
  bool operator ==(object) {

    /*if (this == object) {
      return true;
    }
    if (object == null || toString() != object.toString()) {
      return false;
    }

    Order order = object;

    if (id != order.id) return false;
    if (currency != order.currency) return false;
    if (email != order.email)
      return false;
    if (orderNumber != order.orderNumber) return false;
    if (subtotalPrice != order?.subtotalPrice) return false;
    if (totalShippingPrice != order?.totalShippingPrice) return false;
    if (totalPrice != order.totalPrice) return false;
    if (processedAt != order.processedAt) return false;
    if (orderProducts != order.orderProducts) return false;
    if (address != order?.address) return false;
    if (paginationValue != order?.paginationValue) return false;

    return true;*/

    Order order = object;

    if (id != order.id) return false;

    return true;
  }

  String toString() {
    return "Order{ " +
        " id ='" + id + '\'' +
        ", currency ='" + currency + '\'' +
        ", email ='" + email + '\'' +
        ", orderNumber ='" + orderNumber.toString() + '\'' +
        ", paginationValue ='" + paginationValue + '\'' +
        '}';
  }
}
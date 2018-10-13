import 'dart:convert';
import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/model/address.dart';
import 'package:shopify/model/shipping_rate.dart';

import 'package:json_annotation/json_annotation.dart';

part 'checkout.g.dart';

@JsonSerializable(nullable: false)
class Checkout extends DataObject with _$CheckoutSerializerMixin {
  String checkoutId;
  String webUrl;
  bool requiresShipping;
  double subtotalPrice;
  double totalPrice;
  double taxPrice;
  String currency;
//  Address address;
//  ShippingRate shippingRate;

  Checkout({this.checkoutId, this.webUrl, this.requiresShipping,
    this.subtotalPrice, this.totalPrice, this.taxPrice, this.currency/*,
    this.address, this.shippingRate*/});

  factory Checkout.fromJson(Map<String, dynamic> json) => _$CheckoutFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map();
    map["checkoutId"] = checkoutId;
    map["webUrl"] = webUrl;
    map["requiresShipping"] = requiresShipping;
    map["subtotalPrice"] = subtotalPrice;
    map["totalPrice"] = totalPrice;
    map["taxPrice"] = taxPrice;
    map["currency"] = currency;
    /*if (address != null) {
      map['address'] = address;
    }
    if (shippingRate != null) {
      map["shippingRate"] = shippingRate;
    }*/

    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = checkoutId.hashCode;

    result = 31 * result + webUrl.hashCode;
    result = 31 * result + requiresShipping.hashCode;
    result = 31 * result + subtotalPrice.hashCode;
    result = 31 * result + totalPrice.hashCode;
    result = 31 * result + taxPrice.hashCode;
    result = 31 * result + currency.hashCode;
//    result = 31 * result + (address != null ? address.hashCode : 0);
//    result = 31 * result + (shippingRate != null ? shippingRate.hashCode : 0);
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

    Checkout checkout = object;

    if (checkoutId != checkout.checkoutId) return false;
    if (webUrl != checkout.webUrl) return false;
    if (requiresShipping != checkout.requiresShipping)
      return false;
    if (subtotalPrice != checkout.subtotalPrice) return false;
    if (totalPrice != checkout.totalPrice) return false;
    if (taxPrice != checkout.taxPrice) return false;
    if (currency != checkout.currency) return false;
//    if (address != checkout?.address) return false;
//    if (shippingRate != checkout?.shippingRate) return false;

    return true;
  }


  String toString() {
    return "Checkout{ " +
        " checkoutId ='" + checkoutId + '\'' +
        ", webUrl ='" + webUrl + '\'' +
        ", currency ='" + currency + '\'' +
        '}';
  }
}
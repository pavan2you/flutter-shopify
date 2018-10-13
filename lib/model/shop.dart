import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/model/policy.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'shop.g.dart';

@JsonSerializable(nullable: false)
class Shop extends DataObject with _$ShopSerializerMixin {
  String name;
  String description;
//  Policy privacyPolicy;
//  Policy refundPolicy;
//  Policy termsOfService;

  Shop({this.name, this.description/*, this.privacyPolicy, this.refundPolicy, this.termsOfService*/});

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
//    map["privacyProfile"] = privacyPolicy;
//    map["refundPolicy"] = refundPolicy;
//    map["termsOfService"] = termsOfService;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = name.hashCode;

    result = 31 * result + (description != null ? description.hashCode : 0);
//    result = 31 * result + (privacyPolicy != null ? privacyPolicy.hashCode : 0);
//    result = 31 * result + (refundPolicy != null ? refundPolicy.hashCode : 0);
//    result = 31 * result + (termsOfService != null ? termsOfService.hashCode : 0);
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

    Shop shop = object;

    if (name != shop.name) return false;
    if (description != shop?.description) return false;
//    if (privacyPolicy != shop?.privacyPolicy) return false;
//    if (refundPolicy != shop?.refundPolicy) return false;
//    if (termsOfService != shop?.termsOfService) return false;

    return true;
  }


  String toString() {
    return "Shop{ " +
        " name ='" + name + '\'' +
        ", description ='" + description + '\'' +
        '}';
  }
}
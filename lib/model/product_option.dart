import 'dart:convert';
import 'package:jvanila_flutter/jvanila.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_option.g.dart';

@JsonSerializable(nullable: false)
class ProductOption extends DataObject with _$ProductOptionSerializerMixin {
  String id;
  String name;
  List<String> values;

  ProductOption({this.id, this.name, this.values});

  factory ProductOption.fromJson(Map<String, dynamic> json) => _$ProductOptionFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map();
    map["id"] = id;
    map["name"] = name;
    map["values"] = values;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = id.hashCode;

    result = 31 * result + name.hashCode;
    result = 31 * result + values.hashCode;
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

    ProductOption productOption = object;

    if (id != productOption.id) return false;
    if (name != productOption.name) return false;
    if (values != productOption.values)
      return false;

    return true;
  }

  String toString() {
    return "ProductOption{ " +
        " id ='" + id + '\'' +
        ", name ='" + name + '\'' +
        '}';
  }
}
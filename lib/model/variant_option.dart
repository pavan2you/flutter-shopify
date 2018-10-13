import 'dart:convert';
import 'package:jvanila_flutter/jvanila.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variant_option.g.dart';

@JsonSerializable(nullable: false)
class VariantOption extends DataObject with _$VariantOptionSerializerMixin {
  String name;
  String value;

  VariantOption({this.name, this.value});

  factory VariantOption.fromJson(Map<String, dynamic> json) => _$VariantOptionFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["value"] = value;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = name.hashCode;

    result = 31 * result + value.hashCode;
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

    VariantOption variantOption = object;

    if (name != variantOption.name) return false;
    if (value != variantOption.value) return false;

    return true;
  }

  String toString() {
    return "VariantOption{ " +
        " name ='" + name + '\'' +
        ", value ='" + value + '\'' +
        '}';
  }
}
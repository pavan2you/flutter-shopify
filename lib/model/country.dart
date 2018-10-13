import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/model/state.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable(nullable: false)
class Country extends DataObject with _$CountrySerializerMixin {
  int id;
  String code;
  String name;
  List<State> states;

  Country({this.id, this.code, this.name, this.states});

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["code"] = code;
    map["name"] = name;
    map["states"] = states;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = id.hashCode;

    result = 31 * result + code.hashCode;
    result = 31 * result + name.hashCode;
    result = 31 * result + (states != null ? states.hashCode : 0);
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

    Country country = object;

    if (id != country.id) return false;
    if (code != country.code) return false;
    if (name != country.name)
      return false;
    if (states != country?.states) return false;

    return true;
  }


  String toString() {
    return "Country{ " +
        " id ='" + id.toString() + '\'' +
        ", code ='" + code + '\'' +
        ", name ='" + name + '\'' +
        '}';
  }
}
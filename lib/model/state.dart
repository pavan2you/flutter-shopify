import 'package:jvanila_flutter/jvanila.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable(nullable: false)
class State extends DataObject with _$StateSerializerMixin {
  int id;
  int countryId;
  String code;
  String name;

  State({this.id, this.countryId, this.code, this.name});

  factory State.fromJson(Map<String, dynamic> json) => _$StateFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["countryId"] = countryId;
    map["code"] = code;
    map["name"] = name;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = id.hashCode;

    result = 31 * result + countryId.hashCode;
    result = 31 * result + code.hashCode;
    result = 31 * result + name.hashCode;
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

    State state = object;

    if (id != state.id) return false;
    if (countryId != state.countryId) return false;
    if (code != state.code) return false;
    if (name != state.name)
      return false;

    return true;
  }


  String toString() {
    return "State{ " +
        " id ='" + id.toString() + '\'' +
        ", countryId ='" + countryId.toString() + '\'' +
        ", code ='" + code + '\'' +
        ", name ='" + name + '\'' +
        '}';
  }
}
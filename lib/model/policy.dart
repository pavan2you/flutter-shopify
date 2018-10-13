import 'package:jvanila_flutter/jvanila.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'policy.g.dart';

@JsonSerializable(nullable: false)
class Policy extends DataObject with _$PolicySerializerMixin {
  String title;
  String body;
  String url;

  Policy({this.title, this.body, this.url});

  factory Policy.fromJson(Map<String, dynamic> json) => _$PolicyFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["title"] = title;
    map["body"] = body;
    map["url"] = url;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = title.hashCode;

    result = 31 * result + body.hashCode;
    result = 31 * result + url.hashCode;
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

    Policy policy = object;

    if (title != policy.title) return false;
    if (body != policy.body) return false;
    if (url != policy.url)
      return false;

    return true;
  }


  String toString() {
    return "Policy{ " +
        " title ='" + title + '\'' +
        ", body ='" + body + '\'' +
        ", url ='" + url + '\'' +
        '}';
  }
}
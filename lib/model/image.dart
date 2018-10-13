import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:jvanila_flutter/jvanila.dart';

part 'image.g.dart';

@JsonSerializable(nullable: false)
class ImageDTO extends DataObject with _$ImageDTOSerializerMixin {
  String id;
  String src;
  String alt;

  ImageDTO({this.id, this.src, this.alt});

  factory ImageDTO.fromJson(Map<String, dynamic> json) => _$ImageDTOFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["src"] = src;
    map["alt"] = alt;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = id.hashCode;

    result = 31 * result + src.hashCode;
    result = 31 * result + (alt != null ? alt.hashCode : 0);
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

    ImageDTO image = object;

    if (id != image.id) return false;
    if (src != image.src) return false;
    if (alt != image?.alt)
      return false;

    return true;
  }

  String toString() {
    return "Image{ " +
        " id ='" + id + '\'' +
        ", src ='" + src + '\'' +
        ", alt ='" + alt + '\'' +
        '}';
  }
}
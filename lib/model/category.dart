import 'dart:convert';
import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/model/image.dart';
import 'package:shopify/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(nullable: false)
class Category extends DataObject with _$CategorySerializerMixin {
  String id;
  String title;
  String categoryDescription;
  String additionalDescription;
  ImageDTO image;
  String updatedAt;
  List<Product> productList;
  String paginationValue;
  int categoryNumber;

  Category({this.id, this.title, this.categoryDescription,
    this.additionalDescription, /*this.image,*/ this.updatedAt,
    this.productList, this.paginationValue});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map();
    map["id"] = id;
    map["title"] = title;
    map["categoryDescription"] = categoryDescription;
    map["additionalDescription"] = additionalDescription;
//    map["image"] = image;
    map["updatedAt"] = updatedAt;
    map["productList"] = productList;
    map["paginationValue"] = paginationValue;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = id.hashCode;

    result = 31 * result + title.hashCode;
    result = 31 * result + categoryDescription.hashCode;
    result = 31 * result + additionalDescription.hashCode;
//    result = 31 * result + (image != null ? image.hashCode : 0);
    result = 31 * result + updatedAt.hashCode;
    result = 31 * result + productList.hashCode;
    result = 31 * result + (paginationValue != null ? paginationValue.hashCode : 0);
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

    Category category = object;

    if (id != category.id) return false;
    if (title != category.title) return false;
    if (categoryDescription != category.categoryDescription)
      return false;
    if (additionalDescription != category.additionalDescription) return false;
//    if (image != category?.image) return false;
    if (updatedAt != category.updatedAt) return false;
    if (productList != category.productList) return false;
    if (paginationValue != category?.paginationValue) return false;

    return true;
  }

  String toString() {
    return "Category{ " +
        " id ='" + id + '\'' +
        ", title ='" + title + '\'' +
        ", categoryDescription ='" + categoryDescription + '\'' +
        ", additionalDescription ='" + additionalDescription + '\'' +
        '}';
  }
}
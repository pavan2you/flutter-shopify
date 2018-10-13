// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => new Category(
    id: json['id'] as String,
    title: json['title'] as String,
    categoryDescription: json['categoryDescription'] as String,
    additionalDescription: json['additionalDescription'] as String,
    updatedAt: json['updatedAt'] as String,
    productList: (json['productList'] as List)
        .map((e) => new Product.fromJson(e as Map<String, dynamic>))
        .toList(),
    paginationValue: json['paginationValue'] as String)
  ..crudOperation = json['crudOperation'] as String;

abstract class _$CategorySerializerMixin {
  String get crudOperation;
  String get id;
  String get title;
  String get categoryDescription;
  String get additionalDescription;
  String get updatedAt;
  List<Product> get productList;
  String get paginationValue;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'id': id,
        'title': title,
        'categoryDescription': categoryDescription,
        'additionalDescription': additionalDescription,
        'updatedAt': updatedAt,
        'productList': productList,
        'paginationValue': paginationValue
      };
}

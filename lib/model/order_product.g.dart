// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProduct _$OrderProductFromJson(Map<String, dynamic> json) =>
    new OrderProduct(
        title: json['title'] as String,
        productVariant: new ProductVariant.fromJson(
            json['productVariant'] as Map<String, dynamic>),
        quantity: json['quantity'] as int)
      ..crudOperation = json['crudOperation'] as String;

abstract class _$OrderProductSerializerMixin {
  String get crudOperation;
  String get title;
  ProductVariant get productVariant;
  int get quantity;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'title': title,
        'productVariant': productVariant,
        'quantity': quantity
      };
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartProduct _$CartProductFromJson(Map<String, dynamic> json) {
  return new CartProduct(
      productVariant: new ProductVariant.fromJson(
          json['productVariant'] as Map<String, dynamic>),
      title: json['title'] as String,
      currency: json['currency'] as String,
      quantity: json['quantity'] as int)
    ..crudOperation = json['crudOperation'] as String;
}

abstract class _$CartProductSerializerMixin {
  String get crudOperation;
  ProductVariant get productVariant;
  String get title;
  String get currency;
  int get quantity;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'productVariant': productVariant,
        'title': title,
        'currency': currency,
        'quantity': quantity
      };
}

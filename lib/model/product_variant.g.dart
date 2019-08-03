// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariant _$ProductVariantFromJson(Map<String, dynamic> json) {
  return new ProductVariant(
      id: json['id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      compareAtPrice: (json['compareAtPrice'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool,
      selectedOptions: (json['selectedOptions'] as List)
          .map((e) => new VariantOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: new ImageDTO.fromJson(json['image'] as Map<String, dynamic>),
      productImage:
          new ImageDTO.fromJson(json['productImage'] as Map<String, dynamic>),
      productId: json['productId'] as String)
    ..crudOperation = json['crudOperation'] as String;
}

abstract class _$ProductVariantSerializerMixin {
  String get crudOperation;
  String get id;
  String get title;
  double get price;
  double get compareAtPrice;
  bool get isAvailable;
  List<VariantOption> get selectedOptions;
  ImageDTO get image;
  ImageDTO get productImage;
  String get productId;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'id': id,
        'title': title,
        'price': price,
        'compareAtPrice': compareAtPrice,
        'isAvailable': isAvailable,
        'selectedOptions': selectedOptions,
        'image': image,
        'productImage': productImage,
        'productId': productId
      };
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => new Product(
    id: json['id'] as String,
    title: json['title'] as String,
    productDescription: json['productDescription'] as String,
    additionalDescription: json['additionalDescription'] as String,
    currency: json['currency'] as String,
    price: (json['price'] as num).toDouble(),
    hasAlternativePrice: json['hasAlternativePrice'] as bool,
    discount: json['discount'] as String,
    vendor: json['vendor'] as String,
    type: json['type'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    tags: (json['tags'] as List).map((e) => e as String).toList(),
    images: (json['images'] as List)
        .map((e) => new ImageDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
    options: (json['options'] as List)
        .map((e) => new ProductOption.fromJson(e as Map<String, dynamic>))
        .toList(),
    variants: (json['variants'] as List)
        .map((e) => new ProductVariant.fromJson(e as Map<String, dynamic>))
        .toList(),
    paginationValue: json['paginationValue'] as String)
  ..crudOperation = json['crudOperation'] as String;

abstract class _$ProductSerializerMixin {
  String get crudOperation;
  String get id;
  String get title;
  String get productDescription;
  String get additionalDescription;
  String get currency;
  double get price;
  bool get hasAlternativePrice;
  String get discount;
  String get vendor;
  String get type;
  String get createdAt;
  String get updatedAt;
  List<String> get tags;
  List<ImageDTO> get images;
  List<ProductOption> get options;
  List<ProductVariant> get variants;
  String get paginationValue;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'id': id,
        'title': title,
        'productDescription': productDescription,
        'additionalDescription': additionalDescription,
        'currency': currency,
        'price': price,
        'hasAlternativePrice': hasAlternativePrice,
        'discount': discount,
        'vendor': vendor,
        'type': type,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'tags': tags,
        'images': images,
        'options': options,
        'variants': variants,
        'paginationValue': paginationValue
      };
}

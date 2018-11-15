// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingRate _$ShippingRateFromJson(Map<String, dynamic> json) {
  return new ShippingRate(
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      handle: json['handle'] as String)
    ..crudOperation = json['crudOperation'] as String;
}

abstract class _$ShippingRateSerializerMixin {
  String get crudOperation;
  String get title;
  double get price;
  String get handle;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'title': title,
        'price': price,
        'handle': handle
      };
}

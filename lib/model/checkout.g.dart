// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Checkout _$CheckoutFromJson(Map<String, dynamic> json) => new Checkout(
    checkoutId: json['checkoutId'] as String,
    webUrl: json['webUrl'] as String,
    requiresShipping: json['requiresShipping'] as bool,
    subtotalPrice: (json['subtotalPrice'] as num).toDouble(),
    totalPrice: (json['totalPrice'] as num).toDouble(),
    taxPrice: (json['taxPrice'] as num).toDouble(),
    currency: json['currency'] as String)
  ..crudOperation = json['crudOperation'] as String;

abstract class _$CheckoutSerializerMixin {
  String get crudOperation;
  String get checkoutId;
  String get webUrl;
  bool get requiresShipping;
  double get subtotalPrice;
  double get totalPrice;
  double get taxPrice;
  String get currency;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'checkoutId': checkoutId,
        'webUrl': webUrl,
        'requiresShipping': requiresShipping,
        'subtotalPrice': subtotalPrice,
        'totalPrice': totalPrice,
        'taxPrice': taxPrice,
        'currency': currency
      };
}

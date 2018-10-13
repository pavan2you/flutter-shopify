// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => new Order(
    id: json['id'] as String,
    currency: json['currency'] as String,
    email: json['email'] as String,
    orderNumber: json['orderNumber'] as int,
    subtotalPrice: (json['subtotalPrice'] as num).toDouble(),
    totalShippingPrice: (json['totalShippingPrice'] as num).toDouble(),
    totalPrice: (json['totalPrice'] as num).toDouble(),
    processedAt: json['processedAt'] as String,
    orderProducts: (json['orderProducts'] as List)
        .map((e) => new OrderProduct.fromJson(e as Map<String, dynamic>))
        .toList(),
    address: new Address.fromJson(json['address'] as Map<String, dynamic>),
    paginationValue: json['paginationValue'] as String)
  ..crudOperation = json['crudOperation'] as String;

abstract class _$OrderSerializerMixin {
  String get crudOperation;
  String get id;
  String get currency;
  String get email;
  int get orderNumber;
  double get subtotalPrice;
  double get totalShippingPrice;
  double get totalPrice;
  String get processedAt;
  List<OrderProduct> get orderProducts;
  Address get address;
  String get paginationValue;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'id': id,
        'currency': currency,
        'email': email,
        'orderNumber': orderNumber,
        'subtotalPrice': subtotalPrice,
        'totalShippingPrice': totalShippingPrice,
        'totalPrice': totalPrice,
        'processedAt': processedAt,
        'orderProducts': orderProducts,
        'address': address,
        'paginationValue': paginationValue
      };
}

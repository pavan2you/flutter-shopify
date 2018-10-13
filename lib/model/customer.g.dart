// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => new Customer(
    id: json['id'] as String,
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    phone: json['phone'] as String,
    isAcceptsMarketing: json['isAcceptsMarketing'] as bool,
    addressList: (json['addressList'] as List)
        .map((e) => new Address.fromJson(e as Map<String, dynamic>))
        .toList(),
    defaultAddress:
        new Address.fromJson(json['defaultAddress'] as Map<String, dynamic>))
  ..crudOperation = json['crudOperation'] as String;

abstract class _$CustomerSerializerMixin {
  String get crudOperation;
  String get id;
  String get email;
  String get firstName;
  String get lastName;
  String get phone;
  bool get isAcceptsMarketing;
  List<Address> get addressList;
  Address get defaultAddress;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'isAcceptsMarketing': isAcceptsMarketing,
        'addressList': addressList,
        'defaultAddress': defaultAddress
      };
}

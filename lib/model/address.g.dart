// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return new Address(
      id: json['id'] as String,
      address: json['address'] as String,
      secondAddress: json['secondAddress'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      zip: json['zip'] as String,
      phone: json['phone'] as String)
    ..crudOperation = json['crudOperation'] as String
    ..state = json['state'] as String;
}

abstract class _$AddressSerializerMixin {
  String get crudOperation;
  String get id;
  String get address;
  String get secondAddress;
  String get city;
  String get state;
  String get country;
  String get firstName;
  String get lastName;
  String get zip;
  String get phone;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'id': id,
        'address': address,
        'secondAddress': secondAddress,
        'city': city,
        'state': state,
        'country': country,
        'firstName': firstName,
        'lastName': lastName,
        'zip': zip,
        'phone': phone
      };
}

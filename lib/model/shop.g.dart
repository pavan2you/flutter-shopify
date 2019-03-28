// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) {
  return new Shop(
      name: json['name'] as String, description: json['description'] as String)
    ..crudOperation = json['crudOperation'] as String;
}

abstract class _$ShopSerializerMixin {
  String get crudOperation;
  String get name;
  String get description;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'name': name,
        'description': description
      };
}

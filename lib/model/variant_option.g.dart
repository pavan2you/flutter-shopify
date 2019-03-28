// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariantOption _$VariantOptionFromJson(Map<String, dynamic> json) {
  return new VariantOption(
      name: json['name'] as String, value: json['value'] as String)
    ..crudOperation = json['crudOperation'] as String;
}

abstract class _$VariantOptionSerializerMixin {
  String get crudOperation;
  String get name;
  String get value;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'name': name,
        'value': value
      };
}

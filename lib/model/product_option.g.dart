// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOption _$ProductOptionFromJson(Map<String, dynamic> json) {
  return new ProductOption(
      id: json['id'] == null ? "" : json['id'] as String,
      name: json['name'] as String,
      values: (json['values'] as List).map((e) => e as String).toList())
    ..crudOperation = json['crudOperation'] as String;
}

abstract class _$ProductOptionSerializerMixin {
  String get crudOperation;
  String get id;
  String get name;
  List<String> get values;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'id': id,
        'name': name,
        'values': values
      };
}

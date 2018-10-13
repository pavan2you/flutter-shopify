// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

State _$StateFromJson(Map<String, dynamic> json) => new State(
    id: json['id'] as int,
    countryId: json['countryId'] as int,
    code: json['code'] as String,
    name: json['name'] as String)
  ..crudOperation = json['crudOperation'] as String;

abstract class _$StateSerializerMixin {
  String get crudOperation;
  int get id;
  int get countryId;
  String get code;
  String get name;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'id': id,
        'countryId': countryId,
        'code': code,
        'name': name
      };
}

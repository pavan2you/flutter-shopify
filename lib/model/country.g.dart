// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) {
  return new Country(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      states: (json['states'] as List)
          .map((e) => new State.fromJson(e as Map<String, dynamic>))
          .toList())
    ..crudOperation = json['crudOperation'] as String;
}

abstract class _$CountrySerializerMixin {
  String get crudOperation;
  int get id;
  String get code;
  String get name;
  List<State> get states;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'id': id,
        'code': code,
        'name': name,
        'states': states
      };
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Policy _$PolicyFromJson(Map<String, dynamic> json) => new Policy(
    title: json['title'] as String,
    body: json['body'] as String,
    url: json['url'] as String)
  ..crudOperation = json['crudOperation'] as String;

abstract class _$PolicySerializerMixin {
  String get crudOperation;
  String get title;
  String get body;
  String get url;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'title': title,
        'body': body,
        'url': url
      };
}

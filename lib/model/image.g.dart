// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageDTO _$ImageDTOFromJson(Map<String, dynamic> json) {
  return new ImageDTO(
      id: json['id'] == null ? "" : json['id'] as String,
      src: json['src'] as String,
      alt: json['alt'] as String)
    ..crudOperation = json['crudOperation'] as String;
}

abstract class _$ImageDTOSerializerMixin {
  String get crudOperation;
  String get id;
  String get src;
  String get alt;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'id': id,
        'src': src,
        'alt': alt
      };
}

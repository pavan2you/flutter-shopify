// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => new Author(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    fullName: json['fullName'] as String,
    email: json['email'] as String,
    bio: json['bio'] as String)
  ..crudOperation = json['crudOperation'] as String;

abstract class _$AuthorSerializerMixin {
  String get crudOperation;
  String get firstName;
  String get lastName;
  String get fullName;
  String get email;
  String get bio;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'crudOperation': crudOperation,
        'firstName': firstName,
        'lastName': lastName,
        'fullName': fullName,
        'email': email,
        'bio': bio
      };
}

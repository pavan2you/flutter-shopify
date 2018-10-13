import 'dart:convert';
import 'package:jvanila_flutter/jvanila.dart';
import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable(nullable: false)
class Author extends DataObject with _$AuthorSerializerMixin{
  String firstName;
  String lastName;
  String fullName;
  String email;
  String bio;

  Author({this.firstName, this.lastName, this.fullName,
    this.email, this.bio});

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["fullName"] = fullName;
    map["email"] = email;
    map["bio"] = bio;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = firstName.hashCode;

    result = 31 * result + lastName.hashCode;
    result = 31 * result + fullName.hashCode;
    result = 31 * result + email.hashCode;
    result = 31 * result + (bio != null ? bio.hashCode : 0);
    return result;
  }

  @override
  bool operator ==(object) {

    if (this == object) {
      return true;
    }
    if (object == null || toString() != object.toString()) {
      return false;
    }

    Author author = object;

    if (firstName != author.firstName) return false;
    if (lastName != author.lastName) return false;
    if (fullName != author.fullName)
      return false;
    if (email != author.email) return false;
    if (bio != author?.bio) return false;

    return true;
  }

  String toString() {
    return "Author{ " +
        " firstName ='" + firstName + '\'' +
        ", lastName ='" + lastName + '\'' +
        ", fullName ='" + fullName + '\'' +
        ", email ='" + email + '\'' +
        ", bio ='" + bio + '\'' +
        '}';
  }
}
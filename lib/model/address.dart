import 'dart:convert';

import 'package:jvanila_flutter/jvanila.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(nullable: false)
class Address extends DataObject with _$AddressSerializerMixin {
  String id;
  String primaryAddress;
  String secondAddress;
  String city;
  String state;
  String country;
  String firstName;
  String lastName;
  String zip;
  String phone;

  Address({this.id, this.primaryAddress, this.secondAddress, this.city,
    this.country, this.firstName, this.lastName, this.zip, this.phone});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["primaryAddress"] = primaryAddress;
    map["secondAddress"] = secondAddress;
    map["city"] = city;
    map["country"] = country;
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["zip"] = zip;
    map["phone"] = phone;
    return map;
  }

  @override
  int get hashCode => _getHashCode();

  int _getHashCode() {
    int result = id.hashCode;

    result = 31 * result + primaryAddress.hashCode;
    result = 31 * result + (secondAddress != null ? secondAddress.hashCode : 0);
    result = 31 * result + city.hashCode;
    result = 31 * result + (state != null ? state.hashCode : 0);
    result = 31 * result + country.hashCode;
    result = 31 * result + firstName.hashCode;
    result = 31 * result + lastName.hashCode;
    result = 31 * result + zip.hashCode;
    result = 31 * result + (phone != null ? phone.hashCode : 0);
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

    Address address = object;

    if (id != address.id) return false;
    if (primaryAddress != address.primaryAddress) return false;
    if (secondAddress != address?.secondAddress)
      return false;
    if (city != address.city) return false;
    if (state != address?.state) return false;
    if (country != address.country) return false;
    if (firstName != address.firstName) return false;
    if (lastName != address.lastName) return false;
    if (zip != address.zip) return false;
    if (phone != address?.phone) return false;

    return true;
  }

  @override
  String toString() {
    return "Address{ " +
        " id ='" + id + '\'' +
        ", address ='" + primaryAddress + '\'' +
        ", secondAddress ='" + secondAddress + '\'' +
        ", city ='" + city + '\'' +
        ", state ='" + state + '\'' +
        ", country ='" + country + '\'' +
        ", firstName ='" + firstName + '\'' +
        ", lastName ='" + lastName + '\'' +
        ", zip ='" + zip + '\'' +
        ", phone ='" + phone + '\'' +
        '}';
  }
}

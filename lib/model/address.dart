import 'dart:convert';

import 'package:jvanila_flutter/jvanila.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(nullable: false)
class Address extends DataObject with _$AddressSerializerMixin {
  String id;
  String address;
  String secondAddress;
  String city;
  String state;
  String country;
  String firstName;
  String lastName;
  String zip;
  String company;
  String phone;

  Address({this.id, this.address, this.secondAddress, this.city,
    this.country, this.firstName, this.lastName,
    this.zip, this.company, this.phone});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["address"] = address;
    map["secondAddress"] = secondAddress;
    map["city"] = city;
    map["country"] = country;
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["zip"] = zip;
    map["company"] = company;
    map["phone"] = phone;
    return map;
  }

  @override
  int get hashCode => _getHashCode();

  int _getHashCode() {
    int result = id.hashCode;

    result = 31 * result + address.hashCode;
    result = 31 * result + (secondAddress != null ? secondAddress.hashCode : 0);
    result = 31 * result + city.hashCode;
    result = 31 * result + (state != null ? state.hashCode : 0);
    result = 31 * result + country.hashCode;
    result = 31 * result + firstName.hashCode;
    result = 31 * result + lastName.hashCode;
    result = 31 * result + zip.hashCode;
    result = 31 * result + company.hashCode;
    result = 31 * result + (phone != null ? phone.hashCode : 0);
    return result;
  }

  @override
  bool operator ==(object) {

    /*if (this == object) {
      return true;
    }
    if (object == null || toString() != object.toString()) {
      return false;
    }

    Address addr = object;

    if (id != addr.id) return false;
    if (address != addr.address) return false;
    if (secondAddress != addr?.secondAddress)
      return false;
    if (city != addr.city) return false;
    if (state != addr?.state) return false;
    if (country != addr.country) return false;
    if (firstName != addr.firstName) return false;
    if (lastName != addr.lastName) return false;
    if (zip != addr.zip) return false;
    if (company != addr.company) return false;
    if (phone != addr?.phone) return false;

    return true;*/

    Address addr = object;

    if (id != addr.id) return false;

    return true;
  }

  @override
  String toString() {
    return "Address{ " +
        " id ='" + id + '\'' +
        ", address ='" + address + '\'' +
        ", secondAddress ='" + secondAddress + '\'' +
        ", city ='" + city + '\'' +
        ", state ='" + state + '\'' +
        ", country ='" + country + '\'' +
        ", firstName ='" + firstName + '\'' +
        ", lastName ='" + lastName + '\'' +
        ", zip ='" + zip + '\'' +
        ", company ='" + company + '\'' +
        ", phone ='" + phone + '\'' +
        '}';
  }
}

import 'dart:convert';

import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/model/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable(nullable: false)
class Customer extends DataObject with _$CustomerSerializerMixin {
  String id;
  String email;
  String firstName;
  String lastName;
  String phone;
  bool isAcceptsMarketing;
  List<Address> addressList;
  Address defaultAddress;

  Customer({this.id, this.email, this.firstName, this.lastName, this.phone,
    this.isAcceptsMarketing, this.addressList, this.defaultAddress});

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  @override
  String jsonify() {
    return new JsonEncoder().convert(toJson());
  }

  @override
  Map<String, dynamic> toMap([Map<String, dynamic> map]) {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["phone"] = phone;
    map["isAcceptsMarketing"] = isAcceptsMarketing;
    map["addressList"] = addressList;
    map["defaultAddress"] = defaultAddress;
    return map;
  }

  @override
  int get hashCode => getHashCode();

  int getHashCode() {
    int result = id.hashCode;

    result = 31 * result + email.hashCode;
    result = 31 * result + firstName.hashCode;
    result = 31 * result + lastName.hashCode;
    result = 31 * result + phone.hashCode;
    result = 31 * result + isAcceptsMarketing.hashCode;
    result = 31 * result + addressList.hashCode;
    result = 31 * result + (defaultAddress != null ? defaultAddress.hashCode : 0);
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

    Customer customer = object;

    if (id != customer.id) return false;
    if (email != customer.email) return false;
    if (firstName != customer.firstName)
      return false;
    if (lastName != customer.lastName) return false;
    if (phone != customer.phone) return false;
    if (isAcceptsMarketing != customer.isAcceptsMarketing) return false;
    if (addressList != customer.addressList) return false;
    if (defaultAddress != customer?.defaultAddress) return false;

    return true;
  }


  String toString() {
    return "Customer{ " +
        " id ='" + id + '\'' +
        ", email ='" + email + '\'' +
        ", firstName ='" + firstName + '\'' +
        ", lastName ='" + lastName + '\'' +
        ", phone ='" + phone + '\'' +
        '}';
  }
}
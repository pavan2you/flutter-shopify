import 'package:jvanila_flutter/jvanila.dart';

class CardDetails extends DataObject {
  String firstName;
  String lastName;
  String cardNumber;
  String expireMonth;
  String expireYear;
  String verificationCode;

  CardDetails({this.firstName, this.lastName, this.cardNumber, this.expireMonth,
    this.expireYear, this.verificationCode});

  @override
  int get hashCode => _getHashCode();

  int _getHashCode() {
    int result = firstName.hashCode;

    result = 31 * result + lastName.hashCode;
    result = 31 * result + cardNumber.hashCode;
    result = 31 * result + expireMonth.hashCode;
    result = 31 * result + expireYear.hashCode;
    result = 31 * result + verificationCode.hashCode;
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

    CardDetails card = object;

    if (firstName != card.firstName) return false;
    if (lastName != card.lastName) return false;
    if (cardNumber != card.cardNumber)
      return false;
    if (expireMonth != card.expireMonth) return false;
    if (expireYear != card.expireYear) return false;
    if (verificationCode != card.verificationCode) return false;

    return true;
  }

  String toString() {
    return "Card{ " +
        " firstName ='" + firstName + '\'' +
        ", lastName ='" + lastName + '\'' +
        ", cardNumber ='" + cardNumber + '\'' +
        ", expireMonth ='" + expireMonth + '\'' +
        ", expireYear ='" + expireYear + '\'' +
        ", verificationCode ='" + verificationCode + '\'' +
        '}';
  }
}
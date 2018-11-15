import 'package:jvanila_flutter/jvanila.dart';

class Store extends DataObject {
  String storeId;
  String storeName;
  String storeAddress;

  Store({this.storeId, this.storeName, this.storeAddress});
}
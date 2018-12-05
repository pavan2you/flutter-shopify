import 'package:jvanila_flutter/jvanila.dart';
import 'package:shopify/model/customer.dart';

abstract class IWebView extends IPresentableView {

  void setCustomerInfo(Customer customer);
  void setLoading(bool isLoading);
}
import 'package:jvanila_flutter/jvanila.dart';

class DeliveryInfo extends DataObject {

  double minDeliveryCharges;
  List<String> availableDeliverySlots;
  int numberOfShipments;
  String defaultSelectedDeliverySlot;
  double minPriceForFreeDelivery;
}
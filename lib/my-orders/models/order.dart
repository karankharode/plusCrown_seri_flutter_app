import 'package:flutter/material.dart';
import 'orderItem.dart';

class Order {
  String orderID;
  List<OrderItem> orderItems;

  Order({this.orderID, this.orderItems});
}

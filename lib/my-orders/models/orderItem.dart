import 'package:flutter/material.dart';

class OrderItem {
  String itemName;
  AssetImage orderImage;
  String orderStatus; // delivered (d), return complete (rc), return and refund complete (rrc)
  DateTime date;
  DateTime refundDate;
  double refundAmount;

  OrderItem({
    this.itemName,
    this.orderImage,
    this.orderStatus,
    this.date,
    this.refundDate,
    this.refundAmount,
  });
}

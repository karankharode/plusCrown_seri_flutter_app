import 'package:flutter/cupertino.dart';

import 'order.dart';
import 'orderItem.dart';

List<Order> orderList = [
  Order(
    orderID: "4863964",
    orderItems: [
      OrderItem(
        itemName: "Pen",
        orderImage: AssetImage('assets/stationary/cello signature legacy ball pen.jpeg'),
        orderStatus: 'd',
        date: DateTime(2022, 3, 8),
      ),
      OrderItem(
        itemName: "Pen",
        orderImage: AssetImage('assets/stationary/cello signature legacy ball pen.jpeg'),
        orderStatus: 'd',
        date: DateTime(2022, 1, 24),
      )
    ],
  ),
  Order(
    orderID: "463844",
    orderItems: [
      OrderItem(
        itemName: "Pen",
        orderImage: AssetImage('assets/stationary/cello signature legacy ball pen.jpeg'),
        orderStatus: 'rc',
        date: DateTime(2022, 3, 11),
        refundDate: DateTime(2022, 3, 12),
        refundAmount: 425,
      ),
      OrderItem(
        itemName: "Pen",
        orderImage: AssetImage('assets/stationary/cello signature legacy ball pen.jpeg'),
        orderStatus: 'rrc',
        date: DateTime(2022, 4, 14),
        refundDate: DateTime(2022, 4, 20),
      )
    ],
  ),
];

import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bottomAlignedLogo.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

// ignore: must_be_immutable
class OrderCancellation extends StatelessWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  OrderCancellation({this.loginResponse, this.cartData});

  String orderCancellation = '''
  • You can cancel your order, Before it is accepted by you.

  • You can cancel your order, Before it is shipped or Dispatched along with a reason for cancellation.

  • Those Who return any product, The amount will be credited automatically in your bank account within 48 hours. Those items which are to be returned or exchanged must be unused.
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            buildTextAppBar(context, "Order Cancellation Policy", loginResponse, true, false, null),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
          child: Container(
            height: MediaQuery.of(context).size.height - 115,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    orderCancellation,
                    style: textStyle,
                  ),
                ),
                buildBottomAlignedLogo(context)
              ],
            ),
          ),
        )));
  }
}

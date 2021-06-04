import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bottomAlignedLogo.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

class OrderCancellation extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  OrderCancellation({this.loginResponse, this.cartData});

  @override
  _OrderCancellationState createState() => _OrderCancellationState(loginResponse, cartData);
}

class _OrderCancellationState extends State<OrderCancellation> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _OrderCancellationState(this.loginResponse, this.cartData);

  Future futureForCart;

  var cartController = CartController();

  @override
  void initState() {
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildTextAppBar(context, "Order Cancellation Policy", loginResponse, true, false),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              SizedBox(height: 25),
              Container(
                child: Text(
                  "• You can cancel your order, Before it is accepted by you.",
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 25),
              Container(
                  child: Text(
                "• You can cancel your order, Before it is shipped or Dispatched along with a reason for cancellation.",
                style: TextStyle(
                    fontFamily: 'GothamMedium',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 22,
                    color: Color.fromARGB(255, 71, 54, 111)),
              )),
              SizedBox(height: 25),
              Container(
                child: Text(
                  "• Those Who return any product, The amount will be credited automatically in your bank account within 48 hours. Those items which are to be returned or exchanged must be unused.(check and add)",
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),
                child: buildBottomAlignedLogo(context),
              )
            ],
          ),
        )));
  }
}

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

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
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 71, 54, 111),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'assets/icons/leftarrowwhite.png',
                width: MediaQuery.of(context).size.width * 0.07,
              ),
            ),
          ),
          title: Text(
            "Order Cancellation Policy",
            style: TextStyle(fontFamily: 'GothamMedium', fontSize: 16.sp),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/search3.png',
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FutureBuilder(
                      future: futureForCart,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          CartData cartData = snapshot.data;
                          return GestureDetector(
                            onTap: () {
                              cartData.cartProducts.length == 0
                                  ? Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) => EmptyCartPage(
                                            loginResponse,
                                            cartData,
                                          )))
                                  : Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) => Cart(
                                            loginResponse,
                                            cartData,
                                          )));
                            },
                            child: Badge(
                                position: BadgePosition.topEnd(top: -8, end: -10),
                                badgeColor: Colors.white,
                                badgeContent: Text(
                                  cartData.cartProducts.length.toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: MediaQuery.of(context).size.width / 35),
                                ),
                                child: Image.asset(
                                  'assets/icons/cart1.png',
                                  width: MediaQuery.of(context).size.width * 0.07,
                                )),
                          );
                        } else {
                          return Container();
                        }
                      }),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
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
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Image.asset("assets/images/PlusCrown.png"),
                    )),
              )
            ],
          ),
        )));
  }
}

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class Orders extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const Orders(this.loginResponse, this.cartData);

  @override
  _OrdersState createState() => _OrdersState(loginResponse, cartData);
}

class _OrdersState extends State<Orders> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _OrdersState(this.loginResponse, this.cartData);

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
          "Add Address",
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
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID: ' + ' 4863964',
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding / 2,
                    horizontal: kDefaultPadding / 2,
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                  ),
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kPrimaryColor.withOpacity(0.1),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: size.width * 0.25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPrimaryColor.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.05,
                        left: kDefaultPadding + size.width * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rs ' + '599.00',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Balbharti Textbook',
                            ),
                            Text(
                              'English medium 8th Sanskrit',
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/download_invoice.png',
                              width: size.width * 0.05,
                            ),
                            Text(
                              'Download Invoice',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        orderStatus('Order Approved', "Fri, 02nd Mar'22", true, 1),
                        orderStatus('Order delivered', "Fri, 08th Mar'22", false, 2),
                        orderStatus('Return', "Fri, 09th Mar'22", false, 3),
                        orderStatus('Return Approved', "Fri, 09th Mar'22", false, 4),
                        orderStatus('Pickup', "Expected by, 12th Mar'22", false, 5),
                        orderStatus('Refund', "Expected by, 15th Mar'22", false, 6),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding / 2,
                  ),
                  width: size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kPrimaryColor.withOpacity(0.5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Need help ?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container orderStatus(String status, String date, bool isActive, int index) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? kPrimaryColor : Colors.white,
                  border: Border.all(
                    color: isActive ? Colors.transparent : kPrimaryColor,
                    width: 3,
                  ),
                ),
              ),
              index == 6
                  ? Container()
                  : Container(
                      height: 60,
                      width: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: isActive ? kPrimaryColor : Colors.white,
                        border: Border.all(
                          color: kPrimaryColor,
                        ),
                      ),
                    )
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status,
              ),
              Text(date),
            ],
          )
        ],
      ),
    );
  }
}

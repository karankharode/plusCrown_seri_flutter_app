import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

import '../address/screens/address-book-page.dart';
import 'carts.dart';
import 'controller/CartController.dart';
import 'models/AddToCartData.dart';
import 'models/CartData.dart';

class OrderConfirmation extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  final name;
  final phoneNo;
  final pinCode;
  final city;
  final flatNo;
  final area;
  final landmark;
  final type;

  OrderConfirmation(
      {this.name,
      this.phoneNo,
      this.pinCode,
      this.city,
      this.area,
      this.landmark,
      this.type,
      this.flatNo,
      this.loginResponse,
      this.cartData});

  @override
  _OrderConfirmationState createState() =>
      _OrderConfirmationState(loginResponse, cartData);
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  final LoginResponse loginResponse;
  final CartData cartData;

  var address = [];
  String PaymentMode = "Cash On Delivery";

  _OrderConfirmationState(this.loginResponse, this.cartData);

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
    return
        // wishList.isEmpty
        //   ? Center(
        //   child: Text(
        //     "Your Wish List is empty",
        //     style: TextStyle(fontSize: 20),
        //   ))
        //   :
        Scaffold(
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
                "Order Confirmation",
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
                                      ? Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  EmptyCartPage(
                                                    loginResponse,
                                                    cartData,
                                                  )))
                                      : Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Cart(
                                                    loginResponse,
                                                    cartData,
                                                  )));
                                },
                                child: Badge(
                                    position:
                                        BadgePosition.topEnd(top: -8, end: -10),
                                    badgeColor: Colors.white,
                                    badgeContent: Text(
                                      cartData.cartProducts.length.toString(),
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              35),
                                    ),
                                    child: Image.asset(
                                      'assets/icons/cart1.png',
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
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
                padding: const EdgeInsets.only(
                    left: 11.0, right: 11, top: 18, bottom: 18),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                          child: Container(
                        width: MediaQuery.of(context).size.width - 15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Color.fromARGB(255, 71, 54, 111)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Home Delivery",
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                23),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddressBookPage(loginResponse,
                                                      cartData)));
                                    },
                                    child: Text("Change Address",
                                        //   textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'GothamMedium',
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25)),
                                  )
                                ],
                              ),
                              SizedBox(height: 12),
                              Text("Ohm Chadwik",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontFamily: 'GothamMedium',
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              18)),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Text(
                                    "Plot no. ",
                                    //  textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontFamily: 'GothamMedium',
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                23),
                                  ),
                                  Text("480/203, ",
                                      //   textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontFamily: 'GothamMedium',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              23)),
                                  Text("sai section,",
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              23)),
                                ],
                              ),
                              if (widget.landmark != null)
                                Text("near data mandir,",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                23)),
                              Row(
                                children: [
                                  Text("City - ",
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              23)),
                                  Text("Thane, ",
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              23)),
                                  Text("Dist - ",
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              23)),
                                  Text("Thane, ",
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              23)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("PinCode - ",
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              23)),
                                  Text("416112",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontFamily: 'GothamMedium',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              23)),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(children: [
                                Text("Phone Number - ",
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                23)),
                                Text("6215199399",
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                23)),
                              ])
                            ],
                          ),
                        ),
                      )),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Expected Delivery Date:",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 22)),
                          Text("  01 May 2021",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontSize:
                                      MediaQuery.of(context).size.width / 22)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Divider(
                        color: Color.fromARGB(255, 71, 54, 111),
                        height: 10,
                        thickness: 1,
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Order Amount ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontSize:
                                      MediaQuery.of(context).size.width / 22)),
                          Row(
                            children: [
                              Text(" Rs ",
                                  //   textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              22)),
                              Text("3949    ",
                                  //   textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              22)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Divider(
                        color: Color.fromARGB(255, 71, 54, 111),
                        height: 10,
                        thickness: 1,
                      ),
                      SizedBox(height: 5),
                      Text("Payment Methods",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontSize:
                                  MediaQuery.of(context).size.width / 22)),
                      SizedBox(height: 5),
                      Text(
                          "click on the payment method as per your convenience",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontSize:
                                  MediaQuery.of(context).size.width / 30)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                PaymentMode = 'Online Payment';
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height:
                                  MediaQuery.of(context).size.height * 0.055,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 7),
                                decoration: BoxDecoration(
                                  color: PaymentMode == 'Online Payment'
                                      ? Color.fromARGB(255, 71, 54, 111)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 71, 54, 111)),
                                ),
                                alignment: Alignment.center,
                                child: Text(" Online Payment ",
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: PaymentMode == 'Online Payment'
                                            ? Colors.white
                                            : Color.fromARGB(255, 71, 54, 111),
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                25,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                PaymentMode = 'Cash on Delivery';
                              });
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) => AddressPhoneVerify()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height:
                                  MediaQuery.of(context).size.height * 0.055,
                              padding: EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                color: PaymentMode == 'Cash on Delivery'
                                    ? Color.fromARGB(255, 71, 54, 111)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Color.fromARGB(255, 71, 54, 111)),
                              ),
                              alignment: Alignment.center,
                              child: Text(" Cash on Delivery ",
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      color: PaymentMode == 'Cash on Delivery'
                                          ? Colors.white
                                          : Color.fromARGB(255, 71, 54, 111),
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ));
  }
}

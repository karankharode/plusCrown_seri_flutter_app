import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/contact-us/screens/aboutUsPage.dart';
import 'package:seri_flutter_app/faq/screens/faq_screen.dart';
import 'package:seri_flutter_app/homescreen/others/update_screen.dart';
import 'package:seri_flutter_app/login&signup/controller/login_controller.dart';
import 'package:seri_flutter_app/login&signup/models/LoginData.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:seri_flutter_app/policy/T&C.dart';
import 'package:seri_flutter_app/policy/orderCancellation.dart';
import 'package:seri_flutter_app/return&exchange/screens/return_and_exchange_policy.dart';
import 'package:sizer/sizer.dart';

import '../address/screens/address-book-page.dart';
import '../cart/carts.dart';

class MyAccount extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  MyAccount(this.loginResponse, this.cartData);

  @override
  _MyAccountState createState() =>
      _MyAccountState(loginResponse: loginResponse, cartData: cartData);
}

class _MyAccountState extends State<MyAccount> {
  final LoginResponse loginResponse;
  final CartData cartData;

  var loginController;
  LoginResponse loginResponseForUserDetails;
  Future futureForUserDetails;

  _MyAccountState({this.loginResponse, this.cartData});

  Future futureForCart;

  var cartController = CartController();

  @override
  void initState() {
    loginController = Provider.of<LoginController>(context, listen: false);
    futureForUserDetails = loginController.getUserDetails(new LoginData(
      email: loginResponse.email,
      password: loginResponse.password,
      phoneNumber: loginResponse.phoneNo,
    ));
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
            "My Account",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 11.0, right: 11, top: 18, bottom: 18),
                child: Card(
                  elevation: 0.5,
                  child: Container(
                    //height: 80,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/profile.png",
                        ),
                        radius: MediaQuery.of(context).size.width / 12,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FutureBuilder(
                              future: futureForUserDetails,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  loginResponseForUserDetails = snapshot.data;
                                  return Text(
                                      loginResponseForUserDetails.Firstname +
                                          " " +
                                          loginResponseForUserDetails.Lastname,
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontFamily: 'GothamMedium',
                                          fontSize: MediaQuery.of(context).size.width / 16));
                                } else {
                                  return Container();
                                }
                              }),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Update(loginResponse, cartData)));
                            },
                            child: Text('Edit',
                                style: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    color: Color.fromARGB(255, 71, 54, 111),
                                    fontSize: MediaQuery.of(context).size.width / 23)),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          FutureBuilder(
                              future: futureForUserDetails,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  loginResponseForUserDetails = snapshot.data;
                                  return Text(loginResponseForUserDetails.email,
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontFamily: 'GothamMedium',
                                          fontSize: MediaQuery.of(context).size.width / 23));
                                } else {
                                  return Container();
                                }
                              }),
                          FutureBuilder(
                              future: futureForUserDetails,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  loginResponseForUserDetails = snapshot.data;
                                  return Text(loginResponseForUserDetails.phoneNo,
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontFamily: 'GothamMedium',
                                          fontSize: MediaQuery.of(context).size.width / 23));
                                } else {
                                  return Container();
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Divider(
                    color: Color.fromARGB(255, 71, 54, 111),
                    height: 15,
                    thickness: 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Cart(loginResponse, cartData)));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text("   Orders",
                            style: TextStyle(
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontFamily: 'GothamMedium',
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.width / 18)),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Color.fromARGB(255, 71, 54, 111),
                              size: MediaQuery.of(context).size.width / 22,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 71, 54, 111),
                    height: 15,
                    thickness: 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddressBookPage(loginResponse, cartData)));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text("   Address Book",
                            style: TextStyle(
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontFamily: 'GothamMedium',
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.width / 18)),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Color.fromARGB(255, 71, 54, 111),
                              size: MediaQuery.of(context).size.width / 22,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 71, 54, 111),
                    height: 15,
                    thickness: 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutUsPage(loginResponse, cartData)));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text("   About Us",
                            style: TextStyle(
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontFamily: 'GothamMedium',
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.width / 18)),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Color.fromARGB(255, 71, 54, 111),
                              size: MediaQuery.of(context).size.width / 22,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 71, 54, 111),
                    height: 15,
                    thickness: 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Terms(
                                      loginResponse,
                                      cartData,
                                    )));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text("   Terms and Conditions",
                            style: TextStyle(
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontFamily: 'GothamMedium',
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.width / 18)),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Color.fromARGB(255, 71, 54, 111),
                              size: MediaQuery.of(context).size.width / 22,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 71, 54, 111),
                    height: 15,
                    thickness: 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReturnAndExchangePolicy(
                                      loginResponse: loginResponse,
                                      cartData: cartData,
                                    )));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text("   Return and Exchange Policy",
                            style: TextStyle(
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontFamily: 'GothamMedium',
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.width / 18)),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Color.fromARGB(255, 71, 54, 111),
                              size: MediaQuery.of(context).size.width / 22,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 71, 54, 111),
                    height: 15,
                    thickness: 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderCancellation(
                                      loginResponse: loginResponse,
                                      cartData: cartData,
                                    )));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text("   Order Cancellation Policy",
                            style: TextStyle(
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontFamily: 'GothamMedium',
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.width / 18)),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Color.fromARGB(255, 71, 54, 111),
                              size: MediaQuery.of(context).size.width / 22,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 71, 54, 111),
                    height: 15,
                    thickness: 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FAQSection(loginResponse, cartData)));
                      },
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text("   FAQ's",
                            style: TextStyle(
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontFamily: 'GothamMedium',
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.width / 18)),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Color.fromARGB(255, 71, 54, 111),
                              size: MediaQuery.of(context).size.width / 22,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 71, 54, 111),
                    height: 15,
                    thickness: 0.05,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

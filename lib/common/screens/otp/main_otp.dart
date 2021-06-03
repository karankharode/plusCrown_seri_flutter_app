import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

class Otp_page extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Otp_page(this.loginResponse, this.cartData);

  @override
  _Otp_pageState createState() => _Otp_pageState(loginResponse, cartData);
}

class _Otp_pageState extends State<Otp_page> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _Otp_pageState(this.loginResponse, this.cartData);

  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    border: Border.all(
      color: Color.fromARGB(255, 71, 54, 111).withOpacity(0.5),
    ),
  );

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
            "Cart",
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
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              35),
                                ),
                                child: Image.asset(
                                  'assets/icons/cart1.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(5.w, 6.w, 0, 1.w),
                alignment: Alignment.topLeft,
                child: Text(
                  'Cash on Delivery',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Color.fromARGB(255, 71, 54, 111),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5.w, 0, 0, 4.w),
                alignment: Alignment.topLeft,
                child: Text(
                  'You are willing to pay in cash at the time ofDelivery',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Color.fromARGB(255, 71, 54, 111),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5.w, 0, 0, 3.w),
                alignment: Alignment.topLeft,
                child: Text(
                  'Enter OTP',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Color.fromARGB(255, 71, 54, 111),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 18,
                      right: MediaQuery.of(context).size.width / 12),
                  child: Container(
                    child: PinPut(
                      eachFieldWidth: 15.0,
                      eachFieldHeight: 20.0,
                      withCursor: true,
                      fieldsCount: 4,
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      // onSubmit: (String pin) => _showSnackBar(pin),
                      submittedFieldDecoration: pinPutDecoration,
                      selectedFieldDecoration: pinPutDecoration,
                      followingFieldDecoration: pinPutDecoration,
                      pinAnimationType: PinAnimationType.scale,
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 71, 54, 111),
                          fontSize: 20.0),
                    ),
                  ),
                ),
              ]),
              Container(
                margin: EdgeInsets.fromLTRB(5.w, 5.w, 0, 4.w),
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                      text: "Haven't Received the OTP yet? ",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Color.fromARGB(255, 71, 54, 111),
                        fontWeight: FontWeight.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Resend OTP',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 10.sp,
                            ))
                      ]),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.05,
                  onPressed: () {
                    Alert(
                      context: context,
                      title: "You have entered an invalid OTP",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Try Again",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                          color: Color.fromARGB(255, 71, 54, 111),
                        )
                      ],
                    ).show();
                  },
                  color: Color.fromARGB(255, 71, 54, 111),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

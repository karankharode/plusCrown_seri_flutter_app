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
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

// ignore_for_file: camel_case_types
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
        appBar: buildTextAppBar(context, "Order Confirmation", loginResponse, false, false, null),
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
                  'You are willing to pay in cash at the time of Delivery',
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
                      textStyle:
                          const TextStyle(color: Color.fromARGB(255, 71, 54, 111), fontSize: 20.0),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Submit",
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

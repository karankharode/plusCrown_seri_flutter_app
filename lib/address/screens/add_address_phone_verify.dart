import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/common/screens/otp/main_otp.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

class AddressPhoneVerify extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const AddressPhoneVerify(this.loginResponse, this.cartData);

  @override
  _AddressPhoneVerifyState createState() =>
      _AddressPhoneVerifyState(loginResponse, cartData);
}

class _AddressPhoneVerifyState extends State<AddressPhoneVerify> {
  final LoginResponse loginResponse;
  final CartData cartData;

  final FocusScopeNode _node = FocusScopeNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  MediaQueryData queryData;
  String mobile;

  Future futureForCart;

  var cartController = CartController();

  _AddressPhoneVerifyState(this.loginResponse, this.cartData);

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  void initState() {
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    super.initState();
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
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
          backgroundColor: Color.fromARGB(255, 249, 249, 249),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 25, 10, 10),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 10, 10),
                    child: Text(
                      'Cash on Delivery',
                      style: TextStyle(
                        fontFamily: 'GothamMedium',
                        fontSize: 19.0.sp,
                        color: Color.fromARGB(255, 71, 54, 111),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 10, 10),
                        child: Text(
                          'You are willing to pay in cash at the time of delivery',
                          style: TextStyle(
                            fontFamily: 'GothamMedium',
                            fontSize: 12.0.sp,
                            color: Color.fromARGB(255, 71, 54, 111),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 7.0, 10, 10),
                        child: TextFormField(
                          onChanged: (val) {
                            mobile = val;
                          },
                          cursorColor: Color.fromARGB(255, 71, 54, 111),
                          maxLength: 12,
                          maxLines: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusColor: Color.fromARGB(255, 71, 54, 111),
                            hoverColor: Color.fromARGB(255, 71, 54, 111),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 71, 54, 111)),
                              //borderSide: const BorderSide(),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'GothamMedium',
                              fontSize: 13.0.sp,
                              color: Color.fromARGB(255, 71, 54, 111),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 71, 54, 111),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            fillColor: Colors.white24,
                            hintText: 'Enter Phone Number',
                            counterText: "",
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 15.0),
                        child: Text(
                          'For placing order as COD, Verification is Mandatory',
                          style: TextStyle(
                            fontFamily: 'GothamMedium',
                            fontSize: 12.0.sp,
                            color: Color.fromARGB(255, 71, 54, 111),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 71, 54, 111),
                            shape: const BeveledRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            minimumSize: Size((queryData.size.width / 3),
                                (queryData.size.height / 20)),
                          ),
                          onPressed: () {
                            validateMobile(mobile);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Otp_page(loginResponse, cartData)));
                          },
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              fontFamily: 'GothamMedium',
                              fontSize: 13.0.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

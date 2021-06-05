import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

class RefundDetails extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const RefundDetails(this.loginResponse, this.cartData);

  @override
  _RefundDetailsState createState() =>
      _RefundDetailsState(loginResponse, cartData);
}

class _RefundDetailsState extends State<RefundDetails> {
  final LoginResponse loginResponse;
  final CartData cartData;

  MediaQueryData queryData;
  String recipientName;
  String bankAccNumber;
  String reBankAccNumber;
  String ifscCode;

  _RefundDetailsState(this.loginResponse, this.cartData);

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
    queryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
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
          "Refund Details",
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
        child: Container(
          height: queryData.size.height + 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(15.0, 30.0, 10.0, 15.0),
                child: Text(
                  'Enter bank details for refund process',
                  style: TextStyle(
                    fontFamily: 'GothamMedium',
                    fontSize: 13.0.sp,
                    color: Color.fromARGB(255, 71, 54, 111),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(
                        color: Color.fromARGB(255, 71, 54, 111),
                      )),
                  width: (queryData.size.width / 1.05),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 10.0),
                        child: Text('Recipient name',
                            style: TextStyle(
                              fontFamily: 'GothamMedium',
                              fontSize: 12.0.sp,
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                        child: TextFormField(
                          onChanged: (val) {
                            recipientName = val;
                          },
                          cursorColor: Color.fromARGB(255, 71, 54, 111),
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            focusColor: Color.fromARGB(255, 71, 54, 111),
                            hoverColor: Color.fromARGB(255, 71, 54, 111),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(
                                  width: 2.5,
                                  color: Color.fromARGB(255, 71, 54, 111)),
                              //borderSide: const BorderSide(),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 12.0.sp,
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 71, 54, 111),
                                width: 1,
                              ),
                            ),
                            fillColor: Colors.white24,
                            hintText: '',
                            counterText: "",
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 10.0),
                        child: Text('Enter Bank Account Number',
                            style: TextStyle(
                              fontFamily: 'GothamMedium',
                              fontSize: 12.0.sp,
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                        child: TextFormField(
                          onChanged: (val) {
                            bankAccNumber = val;
                          },
                          cursorColor: Color.fromARGB(255, 71, 54, 111),
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            focusColor: Color.fromARGB(255, 71, 54, 111),
                            hoverColor: Color.fromARGB(255, 71, 54, 111),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 71, 54, 111)),
                              //borderSide: const BorderSide(),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 12.0.sp,
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 71, 54, 111),
                                width: 1,
                              ),
                            ),
                            fillColor: Colors.white24,
                            hintText: '',
                            counterText: "",
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 10.0),
                        child: Text('Re-enter Bank Account Number',
                            style: TextStyle(
                              fontFamily: 'GothamMedium',
                              fontSize: 12.0.sp,
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                        child: TextFormField(
                          onChanged: (val) {
                            reBankAccNumber = val;
                          },
                          cursorColor: Color.fromARGB(255, 71, 54, 111),
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            focusColor: Color.fromARGB(255, 71, 54, 111),
                            hoverColor: Color.fromARGB(255, 71, 54, 111),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 71, 54, 111)),
                              //borderSide: const BorderSide(),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 12.0.sp,
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 71, 54, 111),
                                width: 1,
                              ),
                            ),
                            fillColor: Colors.white24,
                            hintText: '',
                            counterText: "",
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 10.0),
                        child: Text('IFSC code',
                            style: TextStyle(
                              fontSize: 12.0.sp,
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                        child: TextFormField(
                          onChanged: (val) {
                            ifscCode = val;
                          },
                          cursorColor: Color.fromARGB(255, 71, 54, 111),
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            focusColor: Color.fromARGB(255, 71, 54, 111),
                            hoverColor: Color.fromARGB(255, 71, 54, 111),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 71, 54, 111)),
                              //borderSide: const BorderSide(),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 12.0.sp,
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 71, 54, 111),
                                width: 1,
                              ),
                            ),
                            fillColor: Colors.white24,
                            hintText: '',
                            counterText: "",
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
                        child: Text(
                            'This information will be securely saved as per the Terms & Conditions and Privacy Policy',
                            style: TextStyle(
                              fontSize: 12.0.sp,
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 71, 54, 111),
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      minimumSize: Size((queryData.size.width / 2),
                          (queryData.size.height / 25)),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontFamily: 'GothamMedium',
                        fontSize: 12.5.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

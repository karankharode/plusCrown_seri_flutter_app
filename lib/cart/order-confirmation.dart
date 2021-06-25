import 'package:flutter/material.dart';
import 'package:seri_flutter_app/address/models/AddressData.dart';
import 'package:seri_flutter_app/common/screens/otp/main_otp.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/showFlushBar.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import '../address/screens/address-book-page.dart';
import 'controller/CartController.dart';
import 'models/AddToCartData.dart';
import 'models/CartData.dart';

// ignore_for_file: non_constant_identifier_names
class OrderConfirmation extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  final AddressData addressData;

  OrderConfirmation({this.addressData, this.loginResponse, this.cartData});

  @override
  _OrderConfirmationState createState() =>
      _OrderConfirmationState(loginResponse, cartData, addressData);
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  final LoginResponse loginResponse;
  final CartData cartData;
  final AddressData addressData;
  String PaymentMode = "null";

  _OrderConfirmationState(this.loginResponse, this.cartData, this.addressData);

  Future futureForCart;

  var cartController = CartController();

  // Future placeOrder() async {
  //   Navigator.push(context, commonRouter(Otp_page(loginResponse, cartData)));
  //   // bool response = await cartController.placeOrder(
  //   //     OrderData(loginResponse.id.toString(), "First100", addressData.id.toString(), PaymentMode));
  //   if (response) {
  //     showCustomFlushBar(context, "Order Placed", 2);
  //   } else {
  //     showCustomFlushBar(context, "Error Occured", 2);
  //   }
  // }

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
            appBar:
                buildTextAppBar(context, "Order Confirmation", loginResponse, false, false, null),
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 11.0, right: 11, top: 18, bottom: 18),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                          child: Container(
                        width: MediaQuery.of(context).size.width - 15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Home Delivery",
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontSize: MediaQuery.of(context).size.width / 23),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddressBookPage(loginResponse, cartData, true)));
                                    },
                                    child: Text("Change Address",
                                        //   textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'GothamMedium',
                                            fontSize: MediaQuery.of(context).size.width / 25)),
                                  )
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(addressData.name,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontFamily: 'GothamMedium',
                                      fontSize: MediaQuery.of(context).size.width / 18)),
                              SizedBox(height: 12),
                              Text(
                                addressData.line1,
                                //  textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 71, 54, 111),
                                    fontFamily: 'GothamMedium',
                                    fontSize: MediaQuery.of(context).size.width / 23),
                              ),
                              if (false) // landmark
                                Text("near data mandir,",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontSize: MediaQuery.of(context).size.width / 23)),
                              Row(
                                children: [
                                  Text("City - " + addressData.city,
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context).size.width / 23)),
                                  Text("Dist - " + addressData.line2,
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context).size.width / 23)),
                                ],
                              ),
                              Text("Dist - " + addressData.line3,
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontSize: MediaQuery.of(context).size.width / 23)),
                              Text("PinCode - " + addressData.addpincode,
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontSize: MediaQuery.of(context).size.width / 23)),
                              SizedBox(height: 12),
                              // Row(children: [
                              //   Text("Phone Number - " + addressData.,
                              //       style: TextStyle(
                              //           fontFamily: 'GothamMedium',
                              //           color: Color.fromARGB(255, 71, 54, 111),
                              //           fontSize: MediaQuery.of(context).size.width / 23)),

                              // ])
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
                                  fontSize: MediaQuery.of(context).size.width / 22)),
                          Text("  15 June 2021",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontSize: MediaQuery.of(context).size.width / 22)),
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
                                  fontSize: MediaQuery.of(context).size.width / 22)),
                          Row(
                            children: [
                              Text(" \u20B9 " + cartData.cart_total_amount,
                                  //   textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontSize: MediaQuery.of(context).size.width / 22)),
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
                              fontSize: MediaQuery.of(context).size.width / 22)),
                      SizedBox(height: 5),
                      Text("Click on the payment method as per your convenience",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontSize: MediaQuery.of(context).size.width / 30)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                PaymentMode = '2';
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.055,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 7),
                                decoration: BoxDecoration(
                                  color: PaymentMode == '2'
                                      ? Color.fromARGB(255, 71, 54, 111)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                                ),
                                alignment: Alignment.center,
                                child: Text(" Online Payment ",
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: PaymentMode == '2'
                                            ? Colors.white
                                            : Color.fromARGB(255, 71, 54, 111),
                                        fontSize: MediaQuery.of(context).size.width / 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                PaymentMode = '1';
                              });
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) => AddressPhoneVerify()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.055,
                              padding: EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                color: PaymentMode == '1'
                                    ? Color.fromARGB(255, 71, 54, 111)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                              ),
                              alignment: Alignment.center,
                              child: Text(" Cash on Delivery ",
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      color: PaymentMode == '1'
                                          ? Colors.white
                                          : Color.fromARGB(255, 71, 54, 111),
                                      fontSize: MediaQuery.of(context).size.width / 25,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: Center(
                          child: ElevatedButton(
                            child: Text("  Place Order  ",
                                style: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.width / 24)),
                            onPressed: () {
                              if (PaymentMode != "null") {
                                // placeOrder();
                                // Navigator.push(
                                //     context,
                                //     commonRouter((
                                //       loginResponse: loginResponse,
                                //       cartData: cartData,
                                //       addressData: addressData,
                                //     )));
                              } else {
                                showCustomFlushBar(context, "Select Payment Method", 2);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 71, 54, 111),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ));
  }
}

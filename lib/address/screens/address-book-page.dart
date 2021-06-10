import 'package:flutter/material.dart';
import 'package:seri_flutter_app/address/models/AddAddressData.dart';
import 'package:seri_flutter_app/address/models/AddressData.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/cart/order-confirmation.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/showFlushBar.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

import 'add_address.dart';
import 'address-book.dart';

class AddressBookPage extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;
  final bool addressSelection;

  AddressBookPage(this.loginResponse, this.cartData, this.addressSelection);

  @override
  _AddressBookPageState createState() =>
      _AddressBookPageState(loginResponse: loginResponse, cartData: cartData);
}

class _AddressBookPageState extends State<AddressBookPage> {
  final LoginResponse loginResponse;
  final CartData cartData;
  String addId = null;
  AddressData addressData = null;

  Future futureForCart;

  var cartController = CartController();

  updateAddress(String addressId, AddressData newaddressData) {
    setState(() {
      addId = addressId;
      addressData = newaddressData;
    });
  }

  @override
  void initState() {
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    super.initState();
  }

  _AddressBookPageState({this.loginResponse, this.cartData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTextAppBar(context, "Address Book", loginResponse, false, false, null),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 11.0, right: 11, top: 18, bottom: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: AddressBook(loginResponse, cartData, updateAddress)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Address(loginResponse, cartData)));
                  },
                  child: Row(
                    children: [
                      Container(
                          child: Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 71, 54, 111),
                        size: MediaQuery.of(context).size.width / 23,
                      )),
                      SizedBox(width: 4),
                      Text("Add new Address",
                          style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: Color.fromARGB(255, 71, 54, 111),
                            fontSize: MediaQuery.of(context).size.width / 23,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                widget.addressSelection
                    ? Container(
                        width: double.infinity,
                        child: Center(
                          child: ElevatedButton(
                            child: Text("Place Order",
                                style: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    color: Colors.white,
                                    fontSize: MediaQuery.of(context).size.width / 24)),
                            onPressed: () {
                              if (addId != null) {
                                // placeorder();
                                Navigator.push(
                                    context,
                                    commonRouter(OrderConfirmation(
                                      loginResponse: loginResponse,
                                      cartData: cartData,
                                      addressData: addressData,
                                    )));
                              } else {
                                showCustomFlushBar(context, "Select Address", 2);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 71, 54, 111),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            )),
      ),
    );
  }
}

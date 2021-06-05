import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

import 'add_address.dart';
import 'address-book.dart';

class AddressBookPage extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  AddressBookPage(this.loginResponse, this.cartData);

  @override
  _AddressBookPageState createState() =>
      _AddressBookPageState(loginResponse: loginResponse, cartData: cartData);
}

class _AddressBookPageState extends State<AddressBookPage> {
  final LoginResponse loginResponse;
  final CartData cartData;

  Future futureForCart;

  var cartController = CartController();

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
                Flexible(child: AddressBook(loginResponse, cartData)),
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
                SizedBox(height: 5),
              ],
            )),
      ),
    );
  }
}

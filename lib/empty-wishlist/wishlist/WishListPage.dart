import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/common/widgets/appBars/searchBar.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

import 'wish_list.dart';

class WishListPage extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const WishListPage(this.loginResponse, this.cartData);

  @override
  _WishListPageState createState() => _WishListPageState(loginResponse, cartData);
}

class _WishListPageState extends State<WishListPage> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _WishListPageState(this.loginResponse, this.cartData);

  bool search = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: search == false
          ? buildTextAppBar(context, "WishList", loginResponse, false, true, () {
              setState(() {
                search = true;
              });
            })
          : null,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            search == true
                ? SearchBar(context, size, () {
                    setState(() {
                      search = false;
                    });
                  }, loginResponse, cartData)
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: WishList(
                loginResponse: loginResponse,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

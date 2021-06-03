import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/common/widgets/appBars/buildAppBarWithSearch.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'books_screen.dart';

class Books extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Books(this.loginResponse, this.cartData);

  @override
  _BooksState createState() => _BooksState(loginResponse: loginResponse, cartData: cartData);
}

class _BooksState extends State<Books> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _BooksState({this.loginResponse, this.cartData});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBarWithSearch(context, loginResponse, null),
        drawer: CustomDrawer(loginResponse, cartData),
        body: BooksBody(loginResponse, cartData),
      ),
    );
  }
}

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/services/routes/cartPageRouter.dart';

Widget cartwithBadge(loginResponse) {
  return SafeArea(
    child: FutureBuilder(
        future: CartController().getCartDetails(AddToCartData(
          customerId: loginResponse.id,
        )),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CartData cartData = snapshot.data;
            return GestureDetector(
              onTap: () {
                Navigator.push(context, cartPageNavigatorRoute(loginResponse, cartData));
              },
              child: Badge(
                  position: BadgePosition.topEnd(top: 4, end: -8),
                  badgeColor: Colors.white,
                  badgeContent: Text(
                    cartData.cartProducts.length.toString(),
                    style: TextStyle(
                        color: Colors.red, fontSize: MediaQuery.of(context).size.width / 42),
                  ),
                  child: Image.asset(
                    'assets/icons/cart1.png',
                    width: MediaQuery.of(context).size.width * 0.07,
                  )),
            );
          } else {
            return Image.asset(
              'assets/icons/cart1.png',
              width: MediaQuery.of(context).size.width * 0.07,
            );
          }
        }),
  );
}

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/homescreen/screens/home_screen.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

class EmptyCartPage extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  EmptyCartPage(this.loginResponse, this.cartData);

  @override
  _EmptyCartPageState createState() => _EmptyCartPageState(loginResponse, cartData);
}

class _EmptyCartPageState extends State<EmptyCartPage> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _EmptyCartPageState(this.loginResponse, this.cartData);

  MediaQueryData queryData;

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
                          onTap: () {},
                          child: Badge(
                              position: BadgePosition.topEnd(top: -8, end: -10),
                              badgeColor: Colors.white,
                              badgeContent: Text(
                                cartData.cartProducts.length.toString(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: MediaQuery.of(context).size.width / 35),
                              ),
                              child: Image.asset(
                                'assets/icons/cart1.png',
                                width: MediaQuery.of(context).size.width * 0.07,
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30.h,
                  child: Image.asset('assets/icons/empty cart.png'),
                ),
                Text(
                  'Your Cart is Empty',
                  style: TextStyle(
                    fontFamily: 'GothamMedium',
                    color: Color.fromARGB(255, 71, 54, 111),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Add Items to your cart',
                  style: TextStyle(
                    fontFamily: 'GothamMedium',
                    color: Color.fromARGB(255, 71, 54, 111),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 71, 54, 111),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    minimumSize: Size((queryData.size.width / 2), (queryData.size.height / 25)),
                  ),
                  // style: ButtonStyle(elevation: ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => HomePage(loginResponse: loginResponse)));
                  },
                  child: Text(
                    'Shop Now',
                    style: TextStyle(
                      fontFamily: 'GothamMedium',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
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
      appBar: buildTextAppBar(context, "Cart", loginResponse, false, false, null),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                // height: 30.h,
                width: double.infinity,
                height: 330,
                child: Image.asset(
                  'assets/icons/empty cart.png',
                ),
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
    );
  }
}

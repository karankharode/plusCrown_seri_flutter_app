import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/homescreen/screens/home_screen.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

// ignore: camel_case_types
class S_19 extends StatelessWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const S_19(this.loginResponse, this.cartData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.4,
                image: AssetImage('assets/images/successful.png'),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Text(
                  'Order Placed Successfully',
                  style: TextStyle(
                    fontFamily: 'GothamMedium',
                    fontSize: 3.h,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 71, 54, 111),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 71, 54, 111))),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      commonRouter(HomePage(
                        loginResponse: loginResponse,
                        cartData: cartData,
                      )));
                },
                child: Text(
                  "Continue Shopping",
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

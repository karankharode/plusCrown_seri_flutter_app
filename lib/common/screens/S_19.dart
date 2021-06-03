import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: camel_case_types
class S_19 extends StatelessWidget {
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
          ],
        ),
      ),
    );
  }
}

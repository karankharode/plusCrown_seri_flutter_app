import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: camel_case_types
class S_21 extends StatelessWidget {
  const S_21({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.3,
                image: AssetImage('assets/images/cross1.png'),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Text(
                  'Oops Payment Failed',
                  style: TextStyle(
                    fontFamily: 'GothamMedium',
                    fontSize: 3.h,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 71, 54, 111),
                  ),
                )),
            Container(
                padding: EdgeInsets.only(left: 10.w, right: 8.w),
                child: SizedBox(
                    child: Text(
                  'If in case amount is debited from your account, refund will be initiated within 48 hours and credited to your account in 5-7 working days.',
                  style: TextStyle(
                    fontFamily: 'GothamMedium',
                    fontSize: 11.sp,
                    color: Color.fromARGB(255, 71, 54, 111),
                  ),
                ))),
          ],
        ),
      ),
    );
  }
}

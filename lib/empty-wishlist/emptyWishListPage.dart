import 'package:flutter/material.dart';
import 'package:seri_flutter_app/homescreen/screens/home_screen.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

class EmptyWishListPage extends StatelessWidget {
  final LoginResponse loginResponse;

  EmptyWishListPage(
    this.loginResponse,
  );

  MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 15.h,
                child: Image.asset('assets/icons/wishlist empty.png'),
              ),
              SizedBox(height: 2.h),
              Text(
                'You have no items in the wishlist',
                style: TextStyle(
                  fontFamily: 'GothamMedium',
                  color: Color.fromARGB(255, 71, 54, 111),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 71, 54, 111),
                  shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  minimumSize: Size((queryData.size.width / 3), (queryData.size.height / 20)),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(loginResponse: loginResponse)));
                },
                child: Text(
                  'Continue Shopping',
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

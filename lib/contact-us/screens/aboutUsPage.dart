import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bottomAlignedLogo.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

class AboutUsPage extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const AboutUsPage(this.loginResponse, this.cartData);

  @override
  _AboutUsPageState createState() => _AboutUsPageState(loginResponse, cartData);
}

class _AboutUsPageState extends State<AboutUsPage> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _AboutUsPageState(this.loginResponse, this.cartData);

  Future futureForCart;

  var cartController = CartController();
  TextStyle textStyle = TextStyle(
    fontFamily: 'GothamMedium',
    fontSize: 2.1.h,
    fontWeight: FontWeight.w500,
    color: Color(0xFF23124A),
  );

  @override
  void initState() {
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTextAppBar(context, "About Us", loginResponse, true, false, null),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '• Pluscrown is an e-commerce web portal where we thrive to provide educational related materials and stationary from local retailers and suppliers for the students to have easy access to educational products.',
                style: textStyle),
            SizedBox(height: 2.h),
            Text('• We provide all stream books for 11th & 12th stds. (for 8-10 and 11, 12)',
                style: textStyle),
            SizedBox(height: 2.h),
            Text('• We deliver the products at your door steps.', style: textStyle),
            SizedBox(height: 2.h),
            Text(
                '• If you are facing any trouble finding any books or stationary then you Contact Us or mail us.',
                style: textStyle),
            SizedBox(height: 2.h),
            Text(
                '• We strive to achieve customer satisfaction by completing easy user-friendly websites, Quick and user-friendly payment methods and easy tracking options.',
                style: textStyle),
            SizedBox(height: 2.h),
            Text('Thanks for visiting our website.', style: textStyle),
            Spacer(),
            buildBottomAlignedLogo(context),
            // Container(
            //   height: 5.h,
            //   child: Row(
            //     children: [
            //       Spacer(),
            //       Image.asset(
            //         'assets/Logo/Plus Crown  2.png',
            //         width: (MediaQuery.of(context).size.width / 2.5),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

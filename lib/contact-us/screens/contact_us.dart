import 'package:flutter/material.dart';
import 'package:intent/action.dart' as android_action;
import 'package:intent/intent.dart' as android_intent;
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const ContactUs(this.loginResponse, this.cartData);

  @override
  _ContactUsState createState() => _ContactUsState(loginResponse, cartData);
}

class _ContactUsState extends State<ContactUs> {
  final LoginResponse loginResponse;
  final CartData cartData;

  MediaQueryData queryData;

  _ContactUsState(this.loginResponse, this.cartData);

  Future futureForCart;

  var cartController = CartController();

  @override
  void initState() {
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    super.initState();
  }

  callAction() {
    android_intent.Intent()
      ..setAction(android_action.Action.ACTION_VIEW)
      ..setData(Uri(scheme: "tel", path: "+919960622176"))
      ..startActivity().catchError((e) => print(e));
  }

  locationAction() async {
    await launch(
        "https://www.google.com/maps/place/Dream+House/@19.2072,73.1765113,17z/data=!4m8!1m2!2m1!1sDream+House,+Kansai+section,+Ambernath+(E),+%5CnPincode+-+421501,+Dist-+Thane!3m4!1s0x3be7947e4907f4c3:0xfddd74faa60817e8!8m2!3d19.207164!4d73.1787409");
  }

  whatsAppAction() async {
    await launch(
        // Change to working number in Production
        "https://wa.me/+917387183387?text=Hello !");
  }

  emailAction() {
    android_intent.Intent()
      ..setAction(android_action.Action.ACTION_VIEW)
      ..setData(Uri(scheme: "mailto", path: "pluscrown58@gmail.com"))
      ..startActivity().catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Scaffold(
      appBar: buildTextAppBar(context, "Contact Us", loginResponse, true, false, null),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Container(
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //  new Spacer(),
                Column(
                  children: [
                    SizedBox(height: 10),
                    contactUsInfoRowBuilder('assets/icons/call.png', '9960622176', callAction),
                    SizedBox(height: 10),
                    contactUsInfoRowBuilder(
                        'assets/icons/location.png',
                        '627, Dream House, Kansai\nsection, Ambernath (E), \nPincode - 421501, Dist- Thane',
                        locationAction),
                    SizedBox(height: 10),
                    contactUsInfoRowBuilder(
                        'assets/icons/mail.png', 'pluscrown58@gmail.com', emailAction),
                    SizedBox(height: 10),
                    contactUsInfoRowBuilder(
                        'assets/icons/whatsapp icon.png', '9960622176', whatsAppAction),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        'assets/icons/contact_us_bottom_image.jpg',
                        height: (queryData.size.width / 1.13),
                        width: double.infinity,
                      ),
                    ),
                    // buildBottomAlignedLogo(context),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            alignment: Alignment.bottomRight,
                            padding: EdgeInsets.only(right: 0, bottom: 0),
                            child: Image.asset(
                              'assets/images/PlusCrown.png',
                              width: (queryData.size.width / 1.5),
                            )),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container contactUsInfoRowBuilder(iconAssetName, text, pressAction) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(iconAssetName, width: (queryData.size.width / 10)),
          SizedBox(width: queryData.size.width / 25),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.transparent),
            onPressed: pressAction,
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'GothamMedium',
                color: Color.fromARGB(255, 71, 54, 111),
                fontSize: 13.0.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

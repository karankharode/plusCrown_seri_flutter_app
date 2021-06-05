import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bottomAlignedLogo.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

class ReturnAndExchangePolicy extends StatelessWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  ReturnAndExchangePolicy({this.loginResponse, this.cartData});
  MediaQueryData queryData;

  String return_and_exchange_policy = '''
  •  PLUSCROWN  believes in helping our customers and therefore has a cancellation and return policy. If you have received a defective or wrong product you may request a replacement at no extra cost and simply can return it. You should inform us within 48 hours of receiving the delivery, We will refund the amount within 48hrs after we collect it.
  
  •  If you have received the product in a bad condition or if the packaging is tempered before delivery, You can refuse to accept the package and return the package to the delivery person.
  
  •  Please make sure that the original product tag and packing is intact when sending the product back.
  
  •  Return will be processed only if :\n \n1. The product has not been used and has not been altered in any manner.\n \n2. The product is intact and in saleable conditions.\n \n3. The product is accompanied by the original invoice of purchase. \n\n4. 'Non-returnable' tagged products cannot be returned.(non tagged product cannot be returned).\n \n5. In certain cases where the seller is unable to process a replacement for any reason whatsoever, A refund will be given.\n \n6. In case the product is not delivered and you received a delivery confirmation email/SMS, Report the issue within 5 days from the date of delivery confirmation for the seller to investigate.
  
  ''';

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Scaffold(
      appBar:
          buildTextAppBar(context, "Return & Exchange Policy", loginResponse, true, false, null),
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(
            15,
            20,
            10,
            5,
          ),
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              Text(
                return_and_exchange_policy,
                style: TextStyle(
                  fontSize: 2.1.h,
                  fontWeight: FontWeight.w500,
                  // color: Color(0xFF23124A)
                  fontFamily: 'GothamMedium',
                  color: Color.fromARGB(255, 71, 54, 111),
                ),
              ),

              // Container(
              //   margin: EdgeInsets.fromLTRB(0, 0, 5, 20),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         '•',
              //         style: TextStyle(
              //           fontSize: MediaQuery.of(context).size.width / 17,
              //           fontWeight: FontWeight.normal,
              //           color: Color.fromARGB(255, 71, 54, 111),
              //         ),
              //       ),
              //       SizedBox(width: 5),
              //       Flexible(
              //         child: Text(
              //           " PLUSCROWN  believes in helping our customers and therefore has a cancellation and return policy. If you have received a defective or wrong product you may request a replacement at no extra cost and simply can return it. You should inform us within 48 hours of receiving the delivery, We will refund the amount within 48hrs after we collect it.",
              //           style: TextStyle(
              //             fontSize: MediaQuery.of(context).size.width / 22,
              //             fontFamily: 'GothamMedium',
              //             fontWeight: FontWeight.bold,
              //             color: Color.fromARGB(255, 71, 54, 111),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.fromLTRB(0, 0, 5, 20),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         '•',
              //         style: TextStyle(
              //           fontSize: MediaQuery.of(context).size.width / 17,
              //           fontFamily: 'GothamMedium',
              //           fontWeight: FontWeight.normal,
              //           color: Color.fromARGB(255, 71, 54, 111),
              //         ),
              //       ),
              //       SizedBox(width: 5),
              //       Flexible(
              //         child: Text(
              //           " If you have received the product in a bad condition or if the packaging is tempered before delivery, You can refuse to accept the package and return the package to the delivery person.",
              //           style: TextStyle(
              //             fontSize: MediaQuery.of(context).size.width / 22,
              //             fontWeight: FontWeight.bold,
              //             fontFamily: 'GothamMedium',
              //             color: Color.fromARGB(255, 71, 54, 111),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.fromLTRB(0, 0, 5, 20),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         '•',
              //         style: TextStyle(
              //           fontSize: MediaQuery.of(context).size.width / 17,
              //           fontFamily: 'GothamMedium',
              //           fontWeight: FontWeight.normal,
              //           color: Color.fromARGB(255, 71, 54, 111),
              //         ),
              //       ),
              //       SizedBox(width: 5),
              //       Flexible(
              //         child: Text(
              //           " Please make sure that the original product tag and packing is intact when sending the product back.",
              //           style: TextStyle(
              //             fontSize: MediaQuery.of(context).size.width / 22,
              //             fontFamily: 'GothamMedium',
              //             fontWeight: FontWeight.bold,
              //             color: Color.fromARGB(255, 71, 54, 111),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.fromLTRB(0, 0, 5, 10),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         '•',
              //         style: TextStyle(
              //           fontSize: MediaQuery.of(context).size.width / 17,
              //           fontFamily: 'GothamMedium',
              //           fontWeight: FontWeight.normal,
              //           color: Color.fromARGB(255, 71, 54, 111),
              //         ),
              //       ),
              //       SizedBox(width: 5),
              //       Flexible(
              //         child: Text(
              //           " Return will be processed only if :\n \n1. The product has not been used and has not been altered in any manner.\n \n2. The product is intact and in saleable conditions.\n \n3. The product is accompanied by the original invoice of purchase. \n\n4. 'Non-returnable' tagged products cannot be returned.(non tagged product cannot be returned).\n \n5. In certain cases where the seller is unable to process a replacement for any reason whatsoever, A refund will be given.\n \n6. In case the product is not delivered and you received a delivery confirmation email/SMS, Report the issue within 5 days from the date of delivery confirmation for the seller to investigate.",
              //           style: TextStyle(
              //             fontSize: MediaQuery.of(context).size.width / 22,
              //             fontFamily: 'GothamMedium',
              //             fontWeight: FontWeight.bold,
              //             color: Color.fromARGB(255, 71, 54, 111),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              buildBottomAlignedLogo(context)
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Container(
              //         padding: EdgeInsets.fromLTRB(0.0, 10.0, 15.0, 10.0),
              //         alignment: Alignment.bottomRight,
              //         child: Image.asset(
              //           'assets/images/bottom_logo.jpg',
              //           width: (queryData.size.width / 2.5),
              //         )),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

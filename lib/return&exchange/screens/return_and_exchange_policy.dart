import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bottomAlignedLogo.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

// ignore: must_be_immutable
class ReturnAndExchangePolicy extends StatelessWidget {
  final LoginResponse loginResponse;
  final CartData cartData;
  ReturnAndExchangePolicy({this.loginResponse, this.cartData});
  // ignore_for_file: non_constant_identifier_names
  String return_and_exchange_policy = '''
  •  PLUSCROWN  believes in helping our customers and therefore has a cancellation and return policy. If you have received a defective or wrong product you may request a replacement at no extra cost and simply can return it. You should inform us within 48 hours of receiving the delivery, We will refund the amount within 48hrs after we collect it.
  
  •  If you have received the product in a bad condition or if the packaging is tempered before delivery, You can refuse to accept the package and return the package to the delivery person.
  
  •  Please make sure that the original product tag and packing is intact when sending the product back.
  
  •  Return will be processed only if :\n \n1. The product has not been used and has not been altered in any manner.\n \n2. The product is intact and in saleable conditions.\n \n3. The product is accompanied by the original invoice of purchase. \n\n4. 'Non-returnable' tagged products cannot be returned.(non tagged product cannot be returned).\n \n5. In certain cases where the seller is unable to process a replacement for any reason whatsoever, A refund will be given.\n \n6. In case the product is not delivered and you received a delivery confirmation email/SMS, Report the issue within 5 days from the date of delivery confirmation for the seller to investigate.
  
  ''';
  @override
  Widget build(BuildContext context) {
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
                style: textStyle,
              ),
              buildBottomAlignedLogo(context)
            ],
          ),
        ),
      ),
    );
  }
}

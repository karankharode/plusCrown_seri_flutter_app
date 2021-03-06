import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bottomAlignedLogo.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

class Terms extends StatelessWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Terms(this.loginResponse, this.cartData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildTextAppBar(context, "Terms & Conditions", loginResponse, true, false, null),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
          child: Column(
            children: [
              Container(
                child: Text("-- Welcome to Pluscrown --", style: heading),
              ),
              SizedBox(height: 15),
              Container(
                child: Text(
                  '''• All applicable terms and regulations are according to information technology act 2000.
                      
• By accessing this website you agree to be bound by these Web Terms and Conditions.
 
• We request you to read this carefully.

• You can visit websites and services. However, downloading or modifying any portion of the website is strictly prohibited, And you can not duplicate or copy.
''',
                  style: textStyle,
                  // style: TextStyle(
                  //     fontFamily: 'GothamMedium',
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: MediaQuery.of(context).size.width / 24,
                  //     color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              Text(
                '''
• All rights, including copyright and the trademark "Pluscrown" in this website are owned by or licensed to Pluscrown PRIVATE LIMITED.
''',
                style: heading,
                // style: TextStyle(
                //     fontFamily: 'GothamMedium',
                //     fontWeight: FontWeight.w500,
                //     fontSize: MediaQuery.of(context).size.width / 24,
                //     color: Color.fromARGB(255, 71, 54, 111)),
              ),
              Text(
                '''
• All our communication would be conducted by e-mails or by posting notices and messages on the website.

• If you believe that your intellectual property rights have been unfairly used which gives rise to security concerns, please contact us for the correct information or inquiry.

• The website is available only to those who can legally contract under applicable law. If you are under 18, you are prohibited from using purchasing contracting from this website.
''',
                style: textStyle,
                // style: TextStyle(
                //     fontFamily: 'GothamMedium',
                //     fontWeight: FontWeight.w500,
                //     fontSize: MediaQuery.of(context).size.width / 24,
                //     color: Color.fromARGB(255, 71, 54, 111)),
              ),
              buildBottomAlignedLogo(context)
            ],
          ),
        )));
  }
}

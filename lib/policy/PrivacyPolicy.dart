import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bottomAlignedLogo.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

class PrivacyPolicy extends StatelessWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  PrivacyPolicy({this.loginResponse, this.cartData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildTextAppBar(context, "Privacy Policy", loginResponse, true, false),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              SizedBox(height: 15),
              Container(
                child: Text(
                  "• We are very glad that you love our work. Data protection is high priority for the management team of Pluscrown",
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  "\n• We always value your trust upon us. We do not share or sell your Personal information to third-party Agencies. We have set the highest standards of secure transactions and customer information privacy.",
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  "\n• This Website includes Copyrighted Content, such as text, graphics, logos, icons, images and is property of Pluscrown.",
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''\n• What information do we collect from our customers? \n---> When you use our Platform, we collect and store your information which is provided by you during Sign-up and Registration. In general, you can browse the Platform without any details or revealing any personal information about yourself. Once you Register with us, Our main objective behind this is to provide you a safe, efficient and customized shopping experience.
We collect personal information such as --
     . Email address
     . First name and Last name
     . Phone number
     . Address, State, Province, ZIP/Postal code, City
     . Cookies and Usage Data. ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  "\n• We need your prefered information in order to improve our services and experiences within our Sites.",
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  "\n• We automatically collect and store certain types of information about you and your activity on Pluscrown, Including information about your interaction with content available through Pluscrown",
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  "\n• We use your personal information to communicate with you in relation to Pluscrown (e.g.- by Phone, E-mail, Chats).",
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  "\nSecurity:",
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  "\n• We provide strict security standards in order to protect the misuse or changes in the information you provided us.",
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  "\n• Whenever you access your account information, we offer the use of a secure server.",
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''\n • When you access our website we provide you with secure web access.
                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''• It is important for you to be aware, against unauthorized access to your password and to your computers, devices and applications.
                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''• In order to maintain security, We suggest you not share your registered Passwords, This may result in change of the information provided by you, and may be misused by others.
                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''• Once the information is in our database, We do not change it. Only authorized users can make a change.
                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''• We work to protect the security of your personal information during transmission by using encryption protocols and software.

                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''• Our devices offer security features to protect them against unauthorized access and loss of data.
                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''• It is important for you to be aware against unauthorized access in your Account, Computers, devices and applications.
                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''******
                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''-- Changes to this Privacy Policy --
                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''• Please check our Privacy Policy from time to time. We may update this Privacy Policy to reflect changes to our information practices.
                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''-- Children Privacy --
                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''• Our Service does not address anyone under the age of 18.
                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''• We do not collect personally identifiable information from anyone under the age of 18.
                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                  '''• Queries
If you have a query, issue, concern, or complaint in usage of your personal information under this Privacy Policy, please contact us or Email us.

                  ''',
                  style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 22,
                      color: Color.fromARGB(255, 71, 54, 111)),
                ),
              ),
              buildBottomAlignedLogo(context)
            ],
          ),
        )));
  }
}

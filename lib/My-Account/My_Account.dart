import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/services/routes/bottomRouter.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/mockuserDetailsData.dart';
import 'package:seri_flutter_app/contact-us/screens/aboutUsPage.dart';
import 'package:seri_flutter_app/faq/screens/faq_screen.dart';
import 'package:seri_flutter_app/homescreen/others/update_screen.dart';
import 'package:seri_flutter_app/login&signup/controller/login_controller.dart';
import 'package:seri_flutter_app/login&signup/models/LoginData.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:seri_flutter_app/my-orders/screens/myOrdersPage.dart';
import 'package:seri_flutter_app/policy/T&C.dart';
import 'package:seri_flutter_app/policy/orderCancellation.dart';
import 'package:seri_flutter_app/return&exchange/screens/return_and_exchange_policy.dart';
import '../address/screens/address-book-page.dart';

class MyAccount extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  MyAccount(this.loginResponse, this.cartData);

  @override
  _MyAccountState createState() =>
      _MyAccountState(loginResponse: loginResponse, cartData: cartData);
}

class _MyAccountState extends State<MyAccount> {
  final LoginResponse loginResponse;
  final CartData cartData;

  var loginController;
  LoginResponse loginResponseForUserDetails;
  Future futureForUserDetails;

  _MyAccountState({this.loginResponse, this.cartData});

  @override
  void initState() {
    loginController = Provider.of<LoginController>(context, listen: false);
    futureForUserDetails = loginController.getUserDetails(new LoginData(
      email: loginResponse.email,
      password: loginResponse.password,
      phoneNumber: loginResponse.phoneNo,
    ));
    super.initState();
  }

  navigator(destinationRoute) {
    Navigator.push(context, bottomRouter(destinationRoute));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildTextAppBar(context, "My Account", loginResponse, true, false, null),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 7.0, right: 7, top: 18, bottom: 18),
                child: Card(
                  elevation: 3,
                  child: FutureBuilder(
                      future: futureForUserDetails,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          loginResponseForUserDetails = snapshot.data;
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                "assets/images/profile.png",
                              ),
                              radius: MediaQuery.of(context).size.width / 12,
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    loginResponseForUserDetails.Firstname +
                                        " " +
                                        loginResponseForUserDetails.Lastname,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontFamily: 'GothamMedium',
                                        fontSize: MediaQuery.of(context).size.width / 16)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Update(loginResponseForUserDetails, cartData)));
                                  },
                                  child: Text('Edit',
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context).size.width / 23)),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Text(loginResponseForUserDetails.email,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontFamily: 'GothamMedium',
                                        fontSize: MediaQuery.of(context).size.width / 23)),
                                Text(loginResponseForUserDetails.phoneNo,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontFamily: 'GothamMedium',
                                        fontSize: MediaQuery.of(context).size.width / 23)),
                              ],
                            ),
                          );
                        } else {
                          return buildMockUserDetails(context);
                        }
                      }),
                ),
              ),
              Column(
                children: [
                  buildMyAccountTile(context, "My Orders", MyOrdersPage(loginResponse, cartData)),
                  buildMyAccountTile(
                      context, "Address Book", AddressBookPage(loginResponse, cartData, false)),
                  buildMyAccountTile(context, "About Us", AboutUsPage(loginResponse, cartData)),
                  buildMyAccountTile(
                      context, "Terms and Conditions", Terms(loginResponse, cartData)),
                  buildMyAccountTile(
                      context,
                      "Return and Exchange Policy",
                      ReturnAndExchangePolicy(
                        loginResponse: loginResponse,
                        cartData: cartData,
                      )),
                  buildMyAccountTile(
                      context,
                      "Order Cancellation Policy",
                      OrderCancellation(
                        loginResponse: loginResponse,
                        cartData: cartData,
                      )),
                  buildMyAccountTile(context, "FAQ's", FAQSection(loginResponse, cartData)),
                  Divider(
                    color: Color.fromARGB(255, 71, 54, 111),
                    height: 15,
                    thickness: 0.05,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Column buildMyAccountTile(BuildContext context, title, destination) {
    return Column(
      children: [
        Divider(
          color: Color.fromARGB(255, 71, 54, 111),
          height: 18,
          thickness: 0.05,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16),
          child: GestureDetector(
            onTap: () {
              navigator(destination);
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  Icon(Icons.account_balance),
                  Text("   $title",
                      style: TextStyle(
                          color: Color.fromARGB(255, 71, 54, 111),
                          fontFamily: 'GothamMedium',
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width / 18)),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Color.fromARGB(255, 71, 54, 111),
                    size: MediaQuery.of(context).size.width / 22,
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/common/widgets/drawerWidgets/buildDrawerTile.dart';
import 'package:seri_flutter_app/common/widgets/drawerWidgets/buildHomeDrawerTile.dart';
import 'package:seri_flutter_app/contact-us/screens/contact_us.dart';
import 'package:seri_flutter_app/empty-wishlist/wishlist/WishListPage.dart';
import 'package:seri_flutter_app/homescreen/others/biography_screen.dart';
import 'package:seri_flutter_app/homescreen/others/books.dart';
import 'package:seri_flutter_app/homescreen/others/competitve_screen.dart';
import 'package:seri_flutter_app/homescreen/others/stationary.dart';
import 'package:seri_flutter_app/homescreen/others/story_screen.dart';
import 'package:seri_flutter_app/homescreen/screens/home_screen.dart';
import 'package:seri_flutter_app/listing-pages/screens/8_std_page.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:seri_flutter_app/login&signup/screens/login.dart';
import 'package:seri_flutter_app/my-orders/screens/myOrdersPage.dart';
import 'package:sizer/sizer.dart';

import '../../My-Account/My_Account.dart';
import '../../policy/PrivacyPolicy.dart';
import '../shared_pref.dart';

class CustomDrawer extends StatelessWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  CustomDrawer(this.loginResponse, this.cartData);

  final SharedPref _sharedPref = SharedPref.instance;
  homeNavigator(context) {
    Navigator.of(context).pushReplacement(commonRouter(HomePage(
      loginResponse: loginResponse,
      cartData: cartData,
    )));
  }

  drawerNavigator(context, destinationRoute) {
    // Navigator.pop(context);
    Navigator.of(context).push(commonRouter(destinationRoute));
  }

  // nullNavigator(context, destinationRoute) {
  //   // Navigator.pop(context);
  //   // Navigator.of(context).push(commonRouter(destinationRoute));
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 78.w,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      // flex: 4,
                      flex: 5,
                      child: Container(
                        color: Color.fromARGB(255, 71, 54, 111),
                      ),
                    ),
                  ],
                ),
                Positioned.fill(
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(new Radius.circular(14.w)),
                                border: Border.all(color: Colors.black38)),
                            child: CircleAvatar(
                              backgroundColor: Colors.white60,
                              radius: 12.w,
                              child: Image.asset('assets/icons/profile - Copy.png'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              // top: MediaQuery.of(context).size.height / 24,
                              left: MediaQuery.of(context).size.width / 25,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Hello, ' + loginResponse.loggedIn,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontFamily: 'GothamMedium',
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        loginResponse.email,
                                        style: TextStyle(
                                            fontFamily: 'GothamMedium',
                                            color: Colors.white,
                                            fontSize: 9.sp),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        !true
                                            ? 'Delivery not available\nat this pincode'
                                            : "Delievery available\nat 442342",
                                        textAlign: TextAlign.center,
                                        style: !true
                                            ? TextStyle(
                                                fontFamily: 'GothamMedium',
                                                fontSize: 12.sp,
                                                color: Colors.red.withOpacity(0.8),
                                                fontWeight: FontWeight.bold)
                                            : TextStyle(
                                                fontFamily: 'GothamMedium',
                                                fontSize: 12.sp,
                                                color: Colors.green.withOpacity(0.8),
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                drawerHomeTile(context, "Home", homeNavigator),
                Divider(color: Colors.black, height: 0),
                drawerTile(context, 'Notebooks', drawerNavigator, Books(loginResponse, cartData)),
                ExpansionTile(
                  // trailing: Image.asset('assets/icons/downarrow1 - Copy.png'),
                  childrenPadding: EdgeInsets.only(left: 20),

                  title: Text(
                    '8-10th class',
                    style: TextStyle(
                        fontFamily: 'GothamMedium',
                        fontSize: 2.1.h,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF23124A)),
                  ),
                  children: [
                    drawerTile(
                        context,
                        '8th Standard',
                        drawerNavigator,
                        ListingPageForClasses(
                          loginResponse: loginResponse,
                          cartData: cartData,
                          above10th: false,
                          catId: "1",
                        )),
                    drawerTile(
                        context,
                        '9th Standard',
                        drawerNavigator,
                        ListingPageForClasses(
                          loginResponse: loginResponse,
                          cartData: cartData,
                          above10th: false,
                          catId: "2",
                        )),
                    drawerTile(
                        context,
                        '10th Standard',
                        drawerNavigator,
                        ListingPageForClasses(
                          loginResponse: loginResponse,
                          cartData: cartData,
                          above10th: false,
                          catId: "5",
                        )),
                  ],
                ),
                ExpansionTile(
                  // trailing: Image.asset('assets/icons/downarrow1 - Copy.png'),
                  childrenPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    '11-12th class',
                    style: TextStyle(
                        fontFamily: 'GothamMedium',
                        fontSize: 2.1.h,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF23124A)),
                  ),
                  children: [
                    drawerTile(
                        context,
                        '11th Standard',
                        drawerNavigator,
                        ListingPageForClasses(
                          loginResponse: loginResponse,
                          cartData: cartData,
                          above10th: true,
                          catId: "3",
                        )),
                    drawerTile(
                        context,
                        '12th Standard',
                        drawerNavigator,
                        ListingPageForClasses(
                          loginResponse: loginResponse,
                          cartData: cartData,
                          above10th: true,
                          catId: "4",
                        )),
                  ],
                ),
                drawerTile(
                    context, 'JEE/CET/NEET', drawerNavigator, Competitive(loginResponse, cartData)),
                drawerTile(
                    context, 'Story Tellers', drawerNavigator, Story(loginResponse, cartData)),
                drawerTile(
                    context,
                    'Biography Books',
                    drawerNavigator,
                    Biography(
                      loginResponse: loginResponse,
                      cartData: cartData,
                    )),
                drawerTile(context, 'Stationary', drawerNavigator,
                    Stationary(loginResponse: loginResponse, cartData: cartData)),
                Divider(color: Colors.black, height: 0),
                drawerTile(
                    context, 'My Orders', drawerNavigator, MyOrdersPage(loginResponse, cartData)),
                drawerTile(
                    context, 'Wishlist', drawerNavigator, WishListPage(loginResponse, cartData)),
                drawerTile(
                    context, 'My Account', drawerNavigator, MyAccount(loginResponse, cartData)),
                Divider(color: Colors.black, height: 0),
                drawerTile(
                    context,
                    'Privacy Policy',
                    drawerNavigator,
                    PrivacyPolicy(
                      loginResponse: loginResponse,
                      cartData: cartData,
                    )),
                drawerTile(
                    context, 'Contact Us', drawerNavigator, ContactUs(loginResponse, cartData)),
                ListTile(
                    dense: true,
                    title: Text(
                      loginResponse.email == 'guest@gmail.com' ? "Log In" : 'Log Out',
                      style: TextStyle(
                          fontFamily: 'GothamMedium',
                          fontSize: 2.1.h,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF23124A)),
                    ),
                    onTap: () {
                      loginResponse.email == 'guest@gmail.com'
                          ? Navigator.pushAndRemoveUntil(
                              context, commonRouter(LoginPage()), (Route<dynamic> route) => false)
                          : Alert(
                              context: context,
                              title: "Do you want to Log Out?",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () async {
                                    await _sharedPref.removeUser();
                                    await _sharedPref.removeIsLoggedIn();
                                    if (await _sharedPref.readIsLoggedIn() == true) {
                                      await _sharedPref.removeUser();
                                      await _sharedPref.removeIsLoggedIn();
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop(MaterialPageRoute(
                                          builder: (BuildContext context) => LoginPage()));
                                    } else {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (c) => LoginPage()),
                                          (route) => false);
                                    }
                                  },
                                  width: 120,
                                  color: Color.fromARGB(255, 71, 54, 111),
                                ),
                                DialogButton(
                                  child: Text(
                                    "No",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  width: 120,
                                  color: Color.fromARGB(255, 71, 54, 111),
                                )
                              ],
                            ).show();
                    }),
                SizedBox(
                  height: 2.h,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:ui';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/services/Form/textFieldDecoration.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/showFlushBar.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/forgotPass/forgot_password.dart';
import 'package:seri_flutter_app/homescreen/screens/home_screen.dart';
import 'package:seri_flutter_app/login&signup/controller/login_controller.dart';
import 'package:seri_flutter_app/login&signup/models/LoginData.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:seri_flutter_app/login&signup/screens/signup.dart';
import 'package:seri_flutter_app/policy/PrivacyPolicy.dart';
import 'package:seri_flutter_app/policy/T&C.dart';
import 'package:seri_flutter_app/update_customer/controller/update_controller.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, password;
  bool _obscureText = false;
  var loginController;
  var updateController;

  LoginData loginData;
  final _formKey = GlobalKey<FormState>();

  SizedBox gapBox = SizedBox(
    height: kDefaultPadding,
  );

  doLogin() async {
    if (_formKey.currentState.validate()) {
      showCustomFlushBar(context, "Logging you In...", 3);
      loginData = new LoginData(email: email, password: password);
      LoginResponse isAuthorized = await loginController.login(loginData);

      print(isAuthorized.toString());

      if (isAuthorized != null) {
        var cartController = CartController();
        CartData cartData = await cartController.getCartDetails(AddToCartData(
          customerId: isAuthorized.id,
        ));
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => HomePage(
                    loginResponse: isAuthorized,
                    cartData: cartData,
                  )),
          (Route<dynamic> route) => false,
        );
      } else {
        Flushbar(
          margin: EdgeInsets.all(8),
          borderRadius: 8,
          message: "Invalid Email or Password",
          icon: Icon(
            Icons.info_outline,
            size: 20,
            color: Colors.lightBlue[800],
          ),
          duration: Duration(seconds: 2),
        )..show(context);
      }
    } else {
      showCustomFlushBar(context, "Enter Valid Username/Password !", 2);
    }
  }

  doSkipLogin() async {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => HomePage(
              loginResponse: new LoginResponse(
                  Firstname: "guest@gmail.com",
                  Lastname: "Guest",
                  email: "guest@gmail.com",
                  id: 0,
                  loggedIn: "User"),
              cartData: new CartData(
                cartProducts: List.empty(),
              ),
            )));
    Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      message: "Welcome Guest!",
      icon: Icon(
        Icons.info_outline,
        size: 20,
        color: Colors.lightBlue[800],
      ),
      duration: Duration(seconds: 2),
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    loginController = Provider.of<LoginController>(context);
    updateController = Provider.of<UpdateController>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Image.asset(
                        'assets/images/login_top_image.png',
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'GothamMedium',
                              fontSize: 22.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 71, 54, 111),
                            ),
                          ),
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  // height: MediaQuery.of(context).size.height * 0.1,
                                  child: TextFormField(
                                    validator: (val) {
                                      return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(val) ||
                                              RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                                      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                                      r"{0,253}[a-zA-Z0-9])?)*$")
                                                  .hasMatch(val)
                                          ? null
                                          : "Please provide valid number or Email ID";
                                    },
                                    onChanged: (value) => email = value,
                                    cursorColor: Color.fromARGB(255, 71, 54, 111),
                                    decoration: getInputDecoration("Email / PhoneNumber"),
                                  ),
                                ),
                                gapBox,
                                Container(
                                  alignment: Alignment.center,
                                  // height: MediaQuery.of(context).size.height * 0.1,
                                  child: TextFormField(
                                    validator: (val) {
                                      return RegExp(
                                                  "^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).*")
                                              .hasMatch(val)
                                          ? null
                                          : "Input Valid Password";
                                    },
                                    obscureText: !_obscureText,
                                    onChanged: (value) => password = value,
                                    cursorColor: Color.fromARGB(255, 71, 54, 111),
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 71, 54, 111),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                          gapPadding: 10,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 71, 54, 111),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                          gapPadding: 10,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(255, 71, 54, 111),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                          gapPadding: 10,
                                        ),
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                            icon: Icon(
                                              !_obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: !_obscureText
                                                  ? Color.fromARGB(255, 71, 54, 111)
                                                  : Colors.grey[500],
                                            )),
                                        labelText: "Enter Password",
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding,
                                          vertical: kDefaultPadding / 2,
                                        ),
                                        labelStyle: TextStyle(
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontFamily: 'GothamMedium',
                                        )),
                                  ),
                                ),
                              ],
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, commonRouter(ForgotPassword()));
                          },
                          child: Container(
                            alignment: Alignment.bottomRight,
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0.sp,
                                color: Color.fromARGB(255, 71, 54, 111),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "By Continuing, You Agree to the ",
                                style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  fontSize: 11.0.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 71, 54, 111),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '\nPrivacy Policy ',
                                    style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.red,
                                    ),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(context, commonRouter(PrivacyPolicy()));
                                      },
                                  ),
                                  TextSpan(
                                    text: '& ',
                                    style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 71, 54, 111),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Terms and Conditions',
                                    style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.red,
                                    ),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            commonRouter(Terms(
                                              null,
                                              CartData(cartProducts: List.empty()),
                                            )));
                                      },
                                  ),
                                ]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          padding: EdgeInsets.only(top: 0, left: 0),
                          height: MediaQuery.of(context).size.height / 18,
                          width: MediaQuery.of(context).size.width / 2.9,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 71, 54, 111),
                            borderRadius: BorderRadius.circular(10),
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.2,
                            onPressed: () {
                              doLogin();
                            },
                            color: Color.fromARGB(255, 71, 54, 111),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          padding: EdgeInsets.only(top: 0, left: 0),
                          height: MediaQuery.of(context).size.height / 18,
                          width: MediaQuery.of(context).size.width / 2.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.2,
                            onPressed: () {
                              doSkipLogin();
                            },
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Skip Login",
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0.sp,
                                color: Color.fromARGB(255, 71, 54, 111),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.fromLTRB(3, 25, 0, 0),
                          child: RichText(
                            text: TextSpan(
                              text: "Don't Have an Account?",
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 71, 54, 111),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '  Register here',
                                  style: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    fontSize: 13.0.sp,
                                    color: Colors.red[400],
                                  ),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(context, commonRouter(SignupPage()));
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

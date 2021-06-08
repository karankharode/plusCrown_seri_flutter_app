import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:seri_flutter_app/update_customer/controller/update_controller.dart';
import 'package:seri_flutter_app/update_customer/models/UpdateCustomerData.dart';

import '../../constants.dart';

class Update extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Update(this.loginResponse, this.cartData);

  @override
  _UpdateState createState() => _UpdateState(loginResponse: loginResponse, cartData: cartData);
}

class _UpdateState extends State<Update> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _UpdateState({this.loginResponse, this.cartData});

  Future futureForCart;

  var cartController = CartController();

  @override
  void initState() {
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildTextAppBar(context, "Edit Info", loginResponse, false, false, null),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kDefaultPadding,
              ),
              child: UpdateForm(loginResponse: loginResponse),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateForm extends StatefulWidget {
  final LoginResponse loginResponse;

  UpdateForm({this.loginResponse});

  @override
  _UpdateFormState createState() => _UpdateFormState(loginResponse: loginResponse);
}

class _UpdateFormState extends State<UpdateForm> {
  LoginResponse loginResponse;

  _UpdateFormState({this.loginResponse});

  var updateController;
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  int selectedRadio;

  final phoneNumberController = new TextEditingController();
  final emailController = new TextEditingController();
  final passController = new TextEditingController();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    border: Border.all(
      color: kPrimaryColor.withOpacity(0.5),
    ),
  );

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedValue(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  // Widget buildCodeNumberBox(String codeNumber) {
  //   return Container(
  //     padding: EdgeInsets.all(kDefaultPadding / 2),
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         color: kPrimaryColor.withOpacity(0.5),
  //       ),
  //     ),
  //     child: Text(
  //       codeNumber,
  //       style: TextStyle(
  //           fontSize: 22.0, fontWeight: FontWeight.bold, color: kPrimaryColor),
  //     ),
  //   );
  // }

  _showModalBottomSheetForEmail(context, size) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding,
              horizontal: kDefaultPadding,
            ),
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enter New Email Address",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: 'GothamMedium',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Image.asset(
                      'assets/images/cross_purple.png',
                      height: 20,
                    ),
                  ],
                ),
                Spacer(),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontFamily: 'GothamMedium',
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 71, 54, 111),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 71, 54, 111),
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
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding,
                      ),
                      hintText: 'New email address',
                      labelText: 'New email address',
                      hintStyle: TextStyle(
                        fontFamily: 'GothamMedium',
                      )),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                TextFormField(
                  controller: passController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontFamily: 'GothamMedium',
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 71, 54, 111),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        gapPadding: 10,
                      ),
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
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding,
                      ),
                      hintText: 'Password',
                      labelText: 'Password',
                      hintStyle: TextStyle(
                        fontFamily: 'GothamMedium',
                      )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding * 0.5),
                  // margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: MaterialButton(
                    color: kPrimaryColor,
                    onPressed: () {},
                    child: Text(
                      'Confirm Email',
                      style: TextStyle(
                        fontFamily: 'GothamMedium',
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          );
        });
  }

  _showModalBottomSheetForPass(context, size) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding,
            horizontal: kDefaultPadding,
          ),
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Enter New Password",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 15,
                        fontFamily: 'GothamMedium',
                        fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    'assets/images/cross_purple.png',
                    height: 20,
                  ),
                ],
              ),
              Spacer(),
              TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontFamily: 'GothamMedium',
                ),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 71, 54, 111),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      gapPadding: 10,
                    ),
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
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: kDefaultPadding,
                    ),
                    hintText: 'Enter New Password',
                    labelText: 'Password',
                    hintStyle: TextStyle(
                      fontFamily: 'GothamMedium',
                    )),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding * 0.5),
                // margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),

                child: MaterialButton(
                  color: kPrimaryColor,
                  onPressed: () {},
                  child: Text(
                    'Submit new password',
                    style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        );
      },
    );
  }

  _showModalBSForVerification(context, text, size) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding,
            horizontal: kDefaultPadding,
          ),
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Entered new Phone number",
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: kPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        text,
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: kPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/cross_purple.png',
                    height: 20,
                  ),
                ],
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter OTP",
                    style: TextStyle(
                        fontFamily: 'GothamMedium',
                        color: kPrimaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 18,
                          right: MediaQuery.of(context).size.width / 12),
                      child: Container(
                        child: PinPut(
                          eachFieldWidth: 15.0,
                          eachFieldHeight: 20.0,
                          withCursor: true,
                          fieldsCount: 4,
                          focusNode: _pinPutFocusNode,
                          controller: _pinPutController,
                          // onSubmit: (String pin) => _showSnackBar(pin),
                          submittedFieldDecoration: pinPutDecoration,
                          selectedFieldDecoration: pinPutDecoration,
                          followingFieldDecoration: pinPutDecoration,
                          pinAnimationType: PinAnimationType.scale,
                          textStyle: const TextStyle(color: kPrimaryColor, fontSize: 20.0),
                        ),
                      )),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    'Resend OTP',
                    style: TextStyle(fontFamily: 'GothamMedium', color: Colors.red, fontSize: 15.0),
                  )
                ],
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding * 0.5),
                // margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),

                child: MaterialButton(
                  color: kPrimaryColor,
                  onPressed: () {},
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        );
      },
    );
  }

  _showModalBottomSheet(context, size) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding,
            horizontal: kDefaultPadding,
          ),
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Enter New Phone Number",
                    style: TextStyle(
                        fontFamily: 'GothamMedium',
                        color: kPrimaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    'assets/images/cross_purple.png',
                    height: 20,
                  ),
                ],
              ),
              Spacer(),
              TextFormField(
                controller: phoneNumberController,
                style: TextStyle(
                  fontFamily: 'GothamMedium',
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: kDefaultPadding,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 71, 54, 111),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      gapPadding: 10,
                    ),
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
                    hintText: 'Enter New Phone Number',
                    labelText: 'Phone Number',
                    hintStyle: TextStyle(
                      fontFamily: 'GothamMedium',
                    )),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding * 0.5),
                // margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),

                child: MaterialButton(
                  color: kPrimaryColor,
                  onPressed: () {
                    //  _showModalBSForVerification(
                    //     context,
                    //     phoneNumberController.text,
                    //     size,
                    //   );
                    _showModalBSForVerification(context, phoneNumberController.text, size);
                  },
                  child: Text(
                    'Send OTP for Verification',
                    style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    updateController = Provider.of<UpdateController>(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Form(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              style: TextStyle(
                color: kPrimaryColor,
                fontFamily: 'GothamMedium',
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 71, 54, 111),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  gapPadding: 10,
                ),
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
                hintText: 'First Name',
                labelStyle: TextStyle(
                  color: kPrimaryColor,
                ),
                hintStyle: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'GothamMedium',
                ),
                labelText: loginResponse.Firstname,
              ),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              style: TextStyle(
                color: kPrimaryColor,
                fontFamily: 'GothamMedium',
              ),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultPadding / 2,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 71, 54, 111),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    gapPadding: 10,
                  ),
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
                  hintText: 'Last Name',
                  labelText: loginResponse.Lastname,
                  labelStyle: TextStyle(
                    color: kPrimaryColor,
                  ),
                  hintStyle: TextStyle(
                    color: kPrimaryColor,
                    fontFamily: 'GothamMedium',
                  )
                  // suffixIcon: Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                  //   child: SvgPicture.asset(
                  //     'assets/images/edit.svg',
                  //     width: 5,
                  //     height: 5,
                  //   ),
                  // ),
                  ),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: kPrimaryColor,
                fontFamily: 'GothamMedium',
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 71, 54, 111),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  gapPadding: 10,
                ),
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
                hintText: 'Email',
                labelText: loginResponse.email,
                labelStyle: TextStyle(
                  color: kPrimaryColor,
                ),
                hintStyle: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'GothamMedium',
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 1.5),
                  child: GestureDetector(
                    onTap: () {
                      _showModalBottomSheetForEmail(context, size);
                    },
                    child: SvgPicture.asset(
                      'assets/images/edit.svg',
                      width: 3,
                      height: 3,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            TextFormField(
              obscureText: true,
              style: TextStyle(
                color: kPrimaryColor,
                fontFamily: 'GothamMedium',
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 71, 54, 111),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  gapPadding: 10,
                ),
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
                hintText: 'Password',
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: kPrimaryColor,
                ),
                hintStyle: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'GothamMedium',
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _showModalBottomSheetForPass(context, size);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 1.5),
                    child: SvgPicture.asset(
                      'assets/images/edit.svg',
                      width: 5,
                      height: 5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: kPrimaryColor,
                fontFamily: 'GothamMedium',
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 71, 54, 111),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  gapPadding: 10,
                ),
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
                hintText: 'Date of Birth',
                labelText: 'Date of Birth',
                labelStyle: TextStyle(
                  color: kPrimaryColor,
                ),
                hintStyle: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'GothamMedium',
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 1.5),
                  child: Image.asset(
                    'assets/images/downward_arrow.png',
                    width: 5,
                    height: 5,
                  ),
                ),
              ),
            ),
            SizedBox(height: kDefaultPadding),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Gender',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontFamily: 'GothamMedium',
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: 1,
                          activeColor: kPrimaryColor,
                          groupValue: selectedRadio,
                          onChanged: (val) {
                            setSelectedValue(val);
                          },
                        ),
                        Text(
                          'Male',
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: kPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: 2,
                          groupValue: selectedRadio,
                          activeColor: kPrimaryColor,
                          onChanged: (val) {
                            setSelectedValue(val);
                          },
                        ),
                        Text(
                          'Female',
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: kPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ],
                ),
                // SizedBox(
                //   height: kDefaultPadding,
                // ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontFamily: 'GothamMedium',
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: kDefaultPadding / 2,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 71, 54, 111),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      gapPadding: 10,
                    ),
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
                    hintText: 'Phone Number',
                    labelText: loginResponse.phoneNo == "" ? 'Phone Number' : loginResponse.phoneNo,
                    labelStyle: TextStyle(
                      color: kPrimaryColor,
                    ),
                    hintStyle: TextStyle(
                      color: kPrimaryColor,
                      fontFamily: 'GothamMedium',
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 1.5),
                      child: GestureDetector(
                        onTap: () {
                          _showModalBottomSheet(context, size);
                        },
                        child: SvgPicture.asset(
                          'assets/images/edit.svg',
                          width: 5,
                          height: 5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                bool todo = await updateController.updateCustomer(new UpdateCustomerData());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding * 0.5),
                margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
                width: size.width / 2.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: kPrimaryColor,
                ),
                child: Center(
                  child: Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'GothamMedium',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

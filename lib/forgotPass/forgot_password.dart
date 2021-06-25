import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seri_flutter_app/common/services/Form/textFieldDecoration.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/showFlushBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/showLoadingDialog.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/forgotPass/forgot_password_controller.dart';
import 'package:sizer/sizer.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email, otp, password;
  String newPassword, checkPass;

  final _emailKey = GlobalKey<FormState>();
  final _otpKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  bool otpSent = false;
  bool mailConfirmed = false;
  SizedBox gapBox = SizedBox(
    height: kDefaultPadding / 1.5,
  );

  Future sendOtp() async {
    showLoadingDialog(context);
    bool response = await ForgetPasswordController().sendOtp(ModelForgotPassword(email));
    Navigator.pop(context);
    if (response) {
      setState(() {
        otpSent = true;
      });
      showCustomFlushBar(context, "OTP Sent", 2);
    } else {
      showCustomFlushBar(context, "Error Occured", 2);
    }
  }

  Future checkOtp() async {
    bool response = await ForgetPasswordController().checkOtp(CheckOtpModel(otp, email));
    if (response) {
      setState(() {
        mailConfirmed = true;
      });
      showCustomFlushBar(context, "Email Confirmed", 2);
    } else {
      showCustomFlushBar(context, "Error Occured", 2);
    }
  }

  Future resetPassword() async {
    bool response =
        await ForgetPasswordController().resetPassword(PasswordResetData(newPassword, email));
    if (response) {
      showCustomFlushBar(context, "Password was reset Successfully", 2);
      Navigator.pop(context);
    } else {
      showCustomFlushBar(context, "Error Occured", 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTextAppBar(context, "Forgot Password", null, false, false, null),
      body: SingleChildScrollView(
        child: !mailConfirmed
            ? Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Image.asset(
                        'assets/images/login_top_image.png',
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                    gapBox,
                    otpSent
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                headingForgotPass("Forgot Password ?"),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        otpSent = false;
                                      });
                                    },
                                    child: Text(
                                      "Edit Request",
                                      style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        fontSize: 1.8.h,
                                        fontWeight: FontWeight.w500,
                                        color: kPrimaryColor,
                                      ),
                                    ))
                              ])
                        : Container(),
                    Container(
                      alignment: Alignment.center,
                      // height: MediaQuery.of(context).size.height * 0.1,
                      child: Form(
                        key: _emailKey,
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
                          decoration: getInputDecoration("Registered Email Id/Mobile"),
                        ),
                      ),
                    ),
                    !otpSent
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Container(
                              alignment: Alignment.center,
                              // height: MediaQuery.of(context).size.height * 0.1,
                              child: Form(
                                key: _otpKey,
                                child: TextFormField(
                                    maxLength: 4,
                                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                    onChanged: (value) => otp = value,
                                    cursorColor: Color.fromARGB(255, 71, 54, 111),
                                    decoration: getInputDecoration("Enter OTP")),
                              ),
                            ),
                          ),
                    !otpSent
                        ? Container(
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
                                if (_emailKey.currentState.validate()) sendOtp();
                              },
                              color: Color.fromARGB(255, 71, 54, 111),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Send OTP",
                                style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : Container(
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
                                if (_otpKey.currentState.validate()) checkOtp();
                              },
                              color: Color.fromARGB(255, 71, 54, 111),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Verify OTP",
                                style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              )
            :
            // <---
            //  enter new password to reset Password
            //--->

            Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Image.asset(
                        'assets/images/login_top_image.png',
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                    gapBox,
                    headingForgotPass("Enter New Password"),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.9,
                            // height: 65,
                            child: TextFormField(
                              validator: (val) {
                                return RegExp("^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).*")
                                        .hasMatch(val)
                                    ? null
                                    : "Input Valid Password";
                              },
                              onChanged: (value) => newPassword = value,
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
                                  labelText: "Enter New Password",
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding,
                                    vertical: kDefaultPadding / 2,
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 10.0.sp,
                                    fontFamily: 'GothamMedium',
                                    color: Color.fromARGB(255, 71, 54, 111),
                                  )),
                            ),
                          ),
                          gapBox,
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.9,
                            // height: 65,
                            child: TextFormField(
                              cursorColor: Color.fromARGB(255, 71, 54, 111),
                              validator: (val) {
                                return checkPass == newPassword ? null : "Password not matched";
                              },
                              onChanged: (value) => checkPass = value,
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
                                  labelText: "Retype New Password",
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding,
                                    vertical: kDefaultPadding / 2,
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 10.0.sp,
                                    fontFamily: 'GothamMedium',
                                    color: Color.fromARGB(255, 71, 54, 111),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      padding: EdgeInsets.only(top: 0, left: 0),
                      height: MediaQuery.of(context).size.height / 18,
                      width: MediaQuery.of(context).size.width / 2.0,
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
                          if (_formKey.currentState.validate()) resetPassword();
                        },
                        color: Color.fromARGB(255, 71, 54, 111),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Resend Password",
                          style: TextStyle(
                            fontFamily: 'GothamMedium',
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Container headingForgotPass(heading) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
      alignment: Alignment.topLeft,
      child: Text(
        heading,
        style: TextStyle(
          fontFamily: 'GothamMedium',
          fontSize: 20.0.sp,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 71, 54, 111),
        ),
      ),
    );
  }
}

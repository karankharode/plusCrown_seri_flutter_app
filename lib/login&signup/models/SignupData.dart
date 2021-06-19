import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignupData {
  final String firstName;
  final String lastName;
  final String email;
  final int phoneNumber;
  final String password;
  final String userName;
  final String pinCode;

  const SignupData(
      {@required this.pinCode,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.password,
      this.userName});

  FormData getFormData(SignupData signupData) {
    return FormData.fromMap({
      'fname': signupData.firstName,
      'email': signupData.email,
      'number': signupData.phoneNumber,
      'password': signupData.password,
      'username': signupData.userName,
      'lname': signupData.lastName,
      'pincode': signupData.pinCode,
    });
  }

// Map<String, String> toJson() {
//   final data = new Map<String, String>();
//   data['fname'] = this.firstName;
//   data['lname'] = this.lastName;
//   data['email'] = this.email;
//   data['password'] = this.password;
//   data['number'] = this.phoneNumber;
//   data['username'] = this.userName;
//   return data;
// }
}

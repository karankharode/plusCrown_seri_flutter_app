import 'package:dio/dio.dart';

class SignupData {
  final String firstName;
  final String lastName;
  final String email;
  final int phoneNumber;
  final String password;
  final String userName;

  const SignupData(
      {this.firstName,
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
      'lname': "Mayuresh"
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

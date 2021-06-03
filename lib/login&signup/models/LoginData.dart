import 'package:dio/dio.dart';

class LoginData {
  final String email;
  final String phoneNumber;
  final String password;

  const LoginData({this.email, this.phoneNumber, this.password});

  FormData getFormData(LoginData loginData) {
    return FormData.fromMap({
      'email': loginData.email,
      'password': loginData.password,
    });
  }

  // Map<String, String> toJson() {
  //   final data = new Map<String, String>();
  //   data['email'] = this.email;
  //   data['password'] = this.password;
  //   return data;
  // }
}

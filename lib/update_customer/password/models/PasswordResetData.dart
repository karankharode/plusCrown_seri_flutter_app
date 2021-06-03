import 'package:dio/dio.dart';

class PasswordResetData {
  final String email;
  final String password;

  const PasswordResetData({this.email, this.password});

  FormData getFormData(PasswordResetData passwordResetData) {
    return FormData.fromMap({
      'email': passwordResetData.email,
      'password': passwordResetData.password,
    });
  }
}

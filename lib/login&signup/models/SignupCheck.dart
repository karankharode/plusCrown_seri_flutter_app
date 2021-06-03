import 'package:dio/dio.dart';

class SignupCheck {
  final bool registerStatus;
  final bool integrityError;

  SignupCheck({this.integrityError, this.registerStatus});

  factory SignupCheck.getSignUpResponseFromHttpResponse(
      Response<dynamic> response) {
    return SignupCheck(
      registerStatus: response.data['registerStatus'],
      integrityError: response.data['integrityError'],
    );
  }

  factory SignupCheck.fromJson(Map<String, dynamic> json) {
    return SignupCheck(
      registerStatus: json['registerStatus'] ?? "",
      integrityError: json['IntegrityError'] ?? "",
    );
  }
}

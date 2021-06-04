import 'package:dio/dio.dart';

class PasswordResetDataCheck {
  final String msg;

  PasswordResetDataCheck({this.msg});

  // ignore: non_constant_identifier_names
  factory PasswordResetDataCheck.PasswordResetDataCheckData(
      Response<dynamic> response) {
    return PasswordResetDataCheck(
      msg: response.data['msg'],
    );
  }
}

import 'package:dio/dio.dart';

class ChangePasswordData {
  final String id;
  // ignore: non_constant_identifier_names
  final String new_password;

  ChangePasswordData(this.id, this.new_password);

  FormData getFormData(ChangePasswordData changePasswordData) {
    return FormData.fromMap({
      'id': changePasswordData.id,
      'new_password': changePasswordData.new_password,
    });
  }
}

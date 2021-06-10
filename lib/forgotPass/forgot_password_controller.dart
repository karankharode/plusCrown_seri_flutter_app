import 'package:dio/dio.dart';

class ModelForgotPassword {
  final String email;

  ModelForgotPassword(this.email);
  FormData getFormData(ModelForgotPassword modelForgotPassword) {
    return FormData.fromMap({
      'mail': modelForgotPassword.email,
    });
  }
}

class CheckOtpModel {
  final String otp;
  final String email;

  CheckOtpModel(this.otp, this.email);
  FormData getFormData(CheckOtpModel checkOtpModel) {
    return FormData.fromMap({
      'mail': checkOtpModel.email,
      'otp': checkOtpModel.otp,
    });
  }
}

class PasswordResetData {
  final String password;
  final String email;

  PasswordResetData(this.password, this.email);
  FormData getFormData(PasswordResetData passwordResetData) {
    return FormData.fromMap({
      'email': passwordResetData.email,
      'password': passwordResetData.password,
    });
  }
}

class ForgetPasswordController {
  final Dio dio = Dio();
  Future<bool> sendOtp(ModelForgotPassword modelForgotPassword) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/generate_mailotp/";
    final parameters = modelForgotPassword.getFormData(modelForgotPassword);
    try {
      bool serverMsg = await _httpRequestForMailOtp(
        endPointUrl,
        parameters,
      );
      return serverMsg;
    } catch (e) {
      print("caught");
      return null;
    }
  }

  Future<bool> checkOtp(CheckOtpModel checkOtpModel) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/check_mail_otp/";
    final parameters = checkOtpModel.getFormData(checkOtpModel);
    try {
      bool serverMsg = await _httpRequestForCheckMailOtp(
        endPointUrl,
        parameters,
      );
      return serverMsg;
    } catch (e) {
      print("caught");
      return null;
    }
  }

  Future<bool> resetPassword(PasswordResetData passwordResetData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/password_reset/";
    final parameters = passwordResetData.getFormData(passwordResetData);
    try {
      bool serverMsg = await _httpRequestForPasswordReset(
        endPointUrl,
        parameters,
      );
      return serverMsg;
    } catch (e) {
      print("caught");
      return null;
    }
  }

  Future<bool> _httpRequestForMailOtp(String url, FormData formData) async {
    try {
      bool result = false;
      var response = await dio.post(url, data: formData);

      if (response.data['isOTPSent'] == true) {
        result = true;
      }
      return result;
    } catch (e) {
      throw Exception('Error');
    }
  }

  Future<bool> _httpRequestForPasswordReset(String url, FormData formData) async {
    try {
      bool result = false;
      var response = await dio.put(url, data: formData);

      if (response.data['msg'] == "password update Successfully") {
        result = true;
      }
      return result;
    } catch (e) {
      throw Exception('Error');
    }
  }

  Future<bool> _httpRequestForCheckMailOtp(String url, FormData formData) async {
    try {
      bool result = false;
      var response = await dio.put(url, data: formData);

      if (response.data['checkStatus'] == true) {
        result = true;
      }
      return result;
    } catch (e) {
      throw Exception('Error');
    }
  }
}

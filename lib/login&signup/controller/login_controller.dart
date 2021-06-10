import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:seri_flutter_app/common/shared_pref.dart';
import 'package:seri_flutter_app/login&signup/models/LoginData.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:seri_flutter_app/login&signup/models/SignupCheck.dart';
import 'package:seri_flutter_app/login&signup/models/SignupData.dart';

class LoginController {
  static final _sharedPref = SharedPref.instance;
  final dio = Dio();

  Future<bool> isUserAuthorized() async {
    return await SharedPref.instance.readIsLoggedIn();
  }

  Future<LoginResponse> getSavedUserDetails() async {
    String data = await _sharedPref.getUser();
    LoginResponse loginResponse = new LoginResponse.fromJson(json.decode(data));
    return loginResponse;
  }

  Future<bool> signup(SignupData signupData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/register_customer/";
    final parameters = signupData.getFormData(signupData);

    bool serverMsg = await _httpRequestForSignUp(endPointUrl, parameters);
    return serverMsg;
  }

  Future<LoginResponse> getUserDetails(LoginData loginData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/user_details/";
    final parameters = loginData.getFormData(loginData);

    LoginResponse serverMsg = await _httpRequestForUserDetails(
        endPointUrl, parameters, loginData.email, loginData.password, loginData.phoneNumber);
    return serverMsg;
  }

  Future<LoginResponse> login(LoginData loginData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/customer_login/";
    final parameters = loginData.getFormData(loginData);
    try {
      LoginResponse serverMsg = await _httpPostRequest(
          endPointUrl, parameters, loginData.email, loginData.password, loginData.phoneNumber);
      print(serverMsg.toString());
      return serverMsg;
    } catch (e) {
      print("caught");
      return null;
    }
  }

  Future<LoginResponse> _httpRequestForUserDetails(
      String url, FormData formData, String email, String password, String phoneNo) async {
    LoginResponse loginResponse;
    bool isAuthorized = false;
    try {
      var response = await dio.post(url, data: formData);

      if (response.data['status'] == true && response.data['id'] != null) {
        response.data['Email'] = email;
        response.data['Password'] = password;
        response.data['password'] = password;
        loginResponse = LoginResponse.getUserDetailsLoginResponseFromHttpResponse(response);
       
        isAuthorized = true;
      }

      return isAuthorized ? loginResponse : null;
    } catch (e) {
      throw new Exception('Error');
    }
  }

  Future<LoginResponse> _httpPostRequest(
      String url, FormData formData, String email, String password, String phoneNumber) async {
    LoginResponse loginResponse;
    bool isAuthorized = false;
    try {
      var response = await dio.post(url, data: formData);

      if (response.data['status'] == true && response.data['id'] != null) {
        response.data['Email'] = email;
        response.data['Password'] = password;
        response.data['Phone'] = phoneNumber;
        loginResponse =
            LoginResponse.getLoginResponseFromHttpResponse(response, email, password, phoneNumber);
        _sharedPref.saveIsLoggedIn(true);
        _sharedPref.saveUser(json.encode(response.data));
        isAuthorized = true;
      }

      return isAuthorized ? loginResponse : null;
    } catch (e) {
      throw new Exception('Error');
    }
  }

  Future<bool> _httpRequestForSignUp(String url, FormData formData) async {
    try {
      bool result = false;
      var response = await dio.post(url, data: formData);

      var loginResponse = SignupCheck.getSignUpResponseFromHttpResponse(response);
      if (response.data['registerStatus'] == true) {
        result = true;
      }
      return result;
    } catch (e) {
      throw Exception('Error');
    }
  }

  Future<bool> logOut() {
    _sharedPref.removeUser();
    return _sharedPref.removeIsLoggedIn();
  }
}

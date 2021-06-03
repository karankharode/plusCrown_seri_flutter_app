import 'package:dio/dio.dart';
import 'package:seri_flutter_app/update_customer/password/models/ChangePasswordData.dart';
import 'package:seri_flutter_app/update_customer/password/models/PasswordResetData.dart';
import 'package:seri_flutter_app/update_customer/password/models/PasswordResetDataCheck.dart';

class PasswordController {
  final dio = Dio();

  Future<bool> changePassword(ChangePasswordData changePasswordData) async {
    const endPointUrl =
        "https://swaraj.pythonanywhere.com/django/api/update_customer/";
    final parameters = changePasswordData.getFormData(changePasswordData);

    bool serverMsg = await _httpPostChangeRequest(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> _httpPostChangeRequest(String url, FormData formData) async {
    String authToken;
    bool isAuthorized = false;
    try {
      var response = await dio.put(url, data: formData);

      if (response != null) {
        // UpdateCustomerResponse check =
        // UpdateCustomerResponse.getUpdateCustomerResponseData(response);
        print(response.data['detail']);
        //print(check.toString());
        //authToken = _sharedPref.saveIsLoggedIn("Done");
        //_sharedPref.saveUserAuthToken(authToken);
        //_sharedPref.saveUser(json.encode(response));
        isAuthorized = true;
      }

      return isAuthorized;
    } catch (e) {
      throw new Exception('Error');
    }
  }

  Future<bool> resetPassword(PasswordResetData resetData) async {
    const endPointUrl =
        "https://swaraj.pythonanywhere.com/django/api/update_customer/";
    final parameters = resetData.getFormData(resetData);

    bool serverMsg = await _httpPostRequest(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> _httpPostRequest(String url, FormData formData) async {
    String authToken;
    bool isAuthorized = false;
    try {
      var response = await dio.put(url, data: formData);

      if (response != null) {
        PasswordResetDataCheck check =
            PasswordResetDataCheck.PasswordResetDataCheckData(response);
        print(response.data['msg']);
        print(check.toString());
        //authToken = _sharedPref.saveIsLoggedIn("Done");
        //_sharedPref.saveUserAuthToken(authToken);
        //_sharedPref.saveUser(json.encode(response));
        isAuthorized = true;
      }

      return isAuthorized;
    } catch (e) {
      throw new Exception('Error');
    }
  }
}

import 'package:dio/dio.dart';
import 'package:seri_flutter_app/update_customer/models/UpdateCustomerData.dart';
import 'package:seri_flutter_app/update_customer/models/UpdateCustomerResponse.dart';

class UpdateController {
  final dio = Dio();

  Future<bool> updateCustomer(UpdateCustomerData updateCustomerData) async {
    const endPointUrl =
        "https://swaraj.pythonanywhere.com/django/api/update_customer/";
    final parameters = updateCustomerData.getTestFormData(updateCustomerData);

    bool serverMsg = await _httpPostRequest(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> _httpPostRequest(String url, FormData formData) async {
    String authToken;
    bool isAuthorized = false;
    try {
      var response = await dio.put(url, data: formData);

      if (response != null) {
        UpdateCustomerResponse check =
            UpdateCustomerResponse.getUpdateCustomerResponseData(response);
        print(response.data['status']);
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

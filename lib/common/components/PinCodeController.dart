import 'package:dio/dio.dart';

class PinCode {
  final int id;
  final String pinCode;

  PinCode(this.id, this.pinCode);
}

class PinCodeController {
  final dio = Dio();

  Future<List<PinCode>> getPinCode() async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/get_pincode/";

    List<PinCode> serverMsg = await _httpRequestForGetPinCodes(endPointUrl);
    return serverMsg;
  }

  Future<List<PinCode>> _httpRequestForGetPinCodes(String url) async {
    List<PinCode> pincodeList = [];
    try {
      var response = await dio.get(
        url,
      );

      if (response != null) {
        response.data.forEach((data) {
          pincodeList.add(PinCode(data["id"], data['pincode']));
        });
      }

      return pincodeList;
    } catch (e) {
      throw new Exception('Error');
    }
  }
}

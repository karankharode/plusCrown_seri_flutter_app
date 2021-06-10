import 'package:dio/dio.dart';
import 'package:seri_flutter_app/requestBook/modelBook.dart';

class BookRequestController {
  final dio = Dio();
  Future<bool> placeRequest(RequestedBook requestedBook) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/request_book/";
    final parameters = requestedBook.getFormData(requestedBook);

    bool serverMsg = await _httpRequestForPlceRequest(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> _httpRequestForPlceRequest(String url, FormData formData) async {
    try {
      bool result = false;
      var response = await dio.post(url, data: formData);
      print(response.data);

      if (response.data['status'] == true) {
        result = true;
      }
      return result;
    } catch (e) {
      throw Exception('Error');
    }
  }
}

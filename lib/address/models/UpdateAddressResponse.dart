import 'package:dio/dio.dart';

class UpdateAddressResponse {
  final bool status;
  final String message;

  UpdateAddressResponse({this.status, this.message});

  factory UpdateAddressResponse.getUpdateAddressResponseFromHttpResponse(
      Response<dynamic> response) {
    return UpdateAddressResponse(
      status: response.data['status'],
      message: response.data['msg'],
    );
  }
}

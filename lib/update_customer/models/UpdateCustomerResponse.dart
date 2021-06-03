import 'package:dio/dio.dart';

class UpdateCustomerResponse {
  final bool status;
  final String Error;

  const UpdateCustomerResponse({this.status, this.Error});

  factory UpdateCustomerResponse.getUpdateCustomerResponseData(
      Response<dynamic> response) {
    return UpdateCustomerResponse(
      status: response.data['status'],
      Error: response.data['Error'],
    );
  }
}

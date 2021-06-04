import 'package:dio/dio.dart';

class UpdateCustomerResponse {
  final bool status;
  // ignore: non_constant_identifier_names
  final String Error;

  // ignore: non_constant_identifier_names
  const UpdateCustomerResponse({this.status, this.Error});

  factory UpdateCustomerResponse.getUpdateCustomerResponseData(
      Response<dynamic> response) {
    return UpdateCustomerResponse(
      status: response.data['status'],
      Error: response.data['Error'],
    );
  }
}

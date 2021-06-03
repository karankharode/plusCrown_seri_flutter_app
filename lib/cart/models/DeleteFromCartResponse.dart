import 'package:dio/dio.dart';

class DeleteFromCartResponse {
  final String message;

  DeleteFromCartResponse({this.message});

  factory DeleteFromCartResponse.getRemoveCartResponseFromHttpResponse(
      Response<dynamic> response) {
    return DeleteFromCartResponse(
      message: response.data['msg'],
    );
  }
}

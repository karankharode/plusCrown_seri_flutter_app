import 'package:dio/dio.dart';

class AddToCartResponse {
  final String message;

  AddToCartResponse({this.message});

  factory AddToCartResponse.getCartResponseFromHttpResponse(
      Response<dynamic> response) {
    return AddToCartResponse(
      message: response.data['msg'],
    );
  }
}

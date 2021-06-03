import 'package:dio/dio.dart';

class AddToCartData {
  final int customerId;
  final int productId;

  AddToCartData({this.customerId, this.productId});

  FormData getFormData(AddToCartData addToCartData) {
    return FormData.fromMap({
      'id': addToCartData.customerId.toString(),
      'product_id': addToCartData.productId,
    });
  }
}

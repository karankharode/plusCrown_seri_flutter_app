import 'package:dio/dio.dart';

class DeleteFromCartData {
  final int customerId;
  final int productId;

  DeleteFromCartData({this.customerId, this.productId});

  FormData getFormData(DeleteFromCartData deleteFromCartData) {
    return FormData.fromMap({
      'id': deleteFromCartData.customerId,
      'product_id': deleteFromCartData.productId,
    });
  }
}

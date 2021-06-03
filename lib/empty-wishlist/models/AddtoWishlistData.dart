import 'package:dio/dio.dart';

class AddToWishlistData {
  final int customerId;
  final int productId;

  AddToWishlistData({this.customerId, this.productId});

  FormData getFormData(AddToWishlistData addToCartData) {
    return FormData.fromMap({
      'id': addToCartData.customerId.toString(),
      'product_id': addToCartData.productId,
    });
  }
}

class GetWishlistData {
  final int customerId;

  GetWishlistData({this.customerId});

  FormData getFormData(GetWishlistData getWishlistData) {
    return FormData.fromMap({
      'id': getWishlistData.customerId.toString(),
      
    });
  }
}


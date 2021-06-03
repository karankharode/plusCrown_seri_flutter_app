import 'package:dio/dio.dart';
import 'package:seri_flutter_app/common/shared_pref.dart';

import '../models/AddToCartData.dart';
import '../models/AddToCartResponse.dart';
import '../models/CartData.dart';
import '../models/DeleteFromCartData.dart';
import '../models/DeleteFromCartResponse.dart';

class CartController {
  static final _sharedPref = SharedPref.instance;
  final dio = Dio();

  Future<bool> addToCart(AddToCartData addToCartData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/add_to_cart/";
    final parameters = addToCartData.getFormData(addToCartData);

    bool serverMsg = await _httpRequestForAddCartData(endPointUrl, parameters);
    return serverMsg;
  }

  Future<CartData> getCartDetails(AddToCartData addToCartData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/get_cart_details/";
    final parameters = addToCartData.getFormData(addToCartData);

    CartData serverMsg = await _httpRequestForGetCartData(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> removeFromCart(DeleteFromCartData deleteFromCartData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/remove_from_cart/";
    final parameters = deleteFromCartData.getFormData(deleteFromCartData);

    bool serverMsg = await _httpRequestForRemoveCartData(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> _httpRequestForAddCartData(String url, FormData formData) async {
    AddToCartResponse addToCartResponse;
    bool addedToCart;
    try {
      var response = await dio.post(url, data: formData);

      if (response != null) {
        addToCartResponse = AddToCartResponse.getCartResponseFromHttpResponse(response);
        if (response.data['msg'] == "Item added to the Cart") {
          addedToCart = true;
        }
      }

      return addedToCart;
    } catch (e) {
      throw new Exception('Error');
    }
  }

  Future<CartData> _httpRequestForGetCartData(String url, FormData formData) async {
    CartData cardData;
    bool addedToCart;
    try {
      var response = await dio.post(url, data: formData);

      if (response != null) {
        cardData = CartData.fromJson(response);
      }

      return cardData;
    } catch (e) {
      throw new Exception('Error');
    }
  }

  Future<bool> _httpRequestForRemoveCartData(String url, FormData formData) async {
    DeleteFromCartResponse deleteFromCartResponse;
    bool removeFromCart;
    try {
      var response = await dio.post(url, data: formData);

      if (response != null) {
        deleteFromCartResponse =
            DeleteFromCartResponse.getRemoveCartResponseFromHttpResponse(response);
        if (response.data['msg'] == "Item Deleted") {
          removeFromCart = true;
        }
      }

      return removeFromCart;
    } catch (e) {
      throw new Exception('Error');
    }
  }
}

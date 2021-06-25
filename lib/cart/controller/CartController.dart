import 'package:dio/dio.dart';
import 'package:seri_flutter_app/common/shared_pref.dart';

import '../models/AddToCartData.dart';
import '../models/AddToCartResponse.dart';
import '../models/CartData.dart';
import '../models/DeleteFromCartData.dart';
import '../models/DeleteFromCartResponse.dart';

class OrderData {
  final String id;
  final String code;
  final String address_id;
  final String payment_mode;

  String gift_msg;
  String gift_from;

  OrderData(this.id, this.code, this.address_id, this.payment_mode, this.gift_msg, this.gift_from);

  FormData getFormData(OrderData orderData) {
    return FormData.fromMap({
      'id': orderData.id.toString(),
      'code': orderData.code,
      'address_id': orderData.address_id,
      'payment_mode': orderData.payment_mode,
      'gift_message': orderData.gift_msg,
      'gift_from': orderData.gift_from
    });
  }
}

class CompleteOrderData {
  final String id;

  CompleteOrderData(this.id);

  FormData getFormData(CompleteOrderData completeOrderData) {
    return FormData.fromMap({
      'order_id': completeOrderData.id.toString(),
    });
  }
}

class GenerateNumberOTP {
  final String number;

  GenerateNumberOTP(this.number);

  FormData getFormData(GenerateNumberOTP generateNumberOTP) {
    return FormData.fromMap({
      'number': generateNumberOTP.number.toString(),
    });
  }
}

class CheckNumberOTP {
  final String number;
  final String otp;

  CheckNumberOTP(this.number, this.otp);

  FormData getFormData(CheckNumberOTP checkNumberOTP) {
    return FormData.fromMap({
      'number': checkNumberOTP.number.toString(),
      'otp': checkNumberOTP.otp.toString(),
    });
  }
}

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

  Future<List<MyOrderData>> getMyOrderDetails(GetMyOrderData getMyOrderData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/get_order_details/";
    final parameters = getMyOrderData.getFormData(getMyOrderData);

    List<MyOrderData> serverMsg = await _httpRequestForGetMyOrderData(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> removeFromCart(DeleteFromCartData deleteFromCartData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/remove_from_cart/";
    final parameters = deleteFromCartData.getFormData(deleteFromCartData);

    bool serverMsg = await _httpRequestForRemoveCartData(endPointUrl, parameters);
    return serverMsg;
  }

  Future<String> placeOrder(OrderData orderData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/place_order/";
    final parameters = orderData.getFormData(orderData);

    String serverMsg = await _httpRequestForPlaceOrder(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> completeOrder(CompleteOrderData completeOrderData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/complete_order/";
    final parameters = completeOrderData.getFormData(completeOrderData);

    bool serverMsg = await _httpRequestForCompleteOrder(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> generateNumberOtp(GenerateNumberOTP generateNumberOTP) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/generate_otp/";
    final parameters = generateNumberOTP.getFormData(generateNumberOTP);

    bool serverMsg = await _httpRequestForGenerateNumberOtp(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> checkNumberOtp(CheckNumberOTP checkNumberOTP) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/check_otp/";
    final parameters = checkNumberOTP.getFormData(checkNumberOTP);

    bool serverMsg = await _httpRequestForCheckNumberOtp(endPointUrl, parameters);
    return serverMsg;
  }

  Future<bool> _httpRequestForCompleteOrder(String url, FormData formData) async {
    bool addedToCart;
    try {
      var response = await dio.put(url, data: formData);

      if (response != null) {
        if (response.data['message'] == "Order Dispatched") {
          addedToCart = true;
        }
      }

      return addedToCart;
    } catch (e) {
      throw new Exception('Error');
    }
  }

  Future<bool> _httpRequestForGenerateNumberOtp(String url, FormData formData) async {
    bool isOtpSent;
    try {
      var response = await dio.post(url, data: formData);

      if (response != null) {
        if (response.data['isOTPSent']) {
          isOtpSent = true;
        }
      }

      return isOtpSent;
    } catch (e) {
      throw new Exception('Error');
    }
  }

  Future<bool> _httpRequestForCheckNumberOtp(String url, FormData formData) async {
    bool isOtpMatched = false;
    try {
      var response = await dio.put(url, data: formData);

      if (response != null) {
        if (response.data['checkStatus']) {
          isOtpMatched = true;
        }
      }

      return isOtpMatched;
    } catch (e) {
      return false;
    }
  }

  Future<String> _httpRequestForPlaceOrder(String url, FormData formData) async {
    bool addedToCart;
    try {
      var response = await dio.post(url, data: formData);
      if (response != null) {
        print(response.data);
        print(response.data[0]['order_id']);
        return response.data[0]['order_id'].toString();
        // if (response.data['order_id'] == "Order Placed") {
        //   addedToCart = true;
        // }
      }

      return null;
    } catch (e) {
      throw new Exception('Error');
    }
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

  Future<List<MyOrderData>> _httpRequestForGetMyOrderData(String url, FormData formData) async {
    List<MyOrderData> orderData = [];
    try {
      var response = await dio.post(url, data: formData);

      if (response != null) {
        response.data.forEach((data) {
          // print("loop ");
          try {
            MyOrderData myOrder = MyOrderData.getProduct(data);
            orderData.add(myOrder);
            print("Added");
          } catch (e) {}
        });
      }
      print("orderData: $orderData");
      return orderData;
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

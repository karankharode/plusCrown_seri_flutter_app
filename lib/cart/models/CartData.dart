import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:seri_flutter_app/address/models/AddressData.dart';

String urlToAppend = "https://swaraj.pythonanywhere.com/media/";

class CartData {
  final String cartOwner;
  final List<CartProduct> cartProducts;
  final String cartPrice;

  final String cart_mrp; // "150.00",
  final String cart_saving; // "30.00",
  final String cart_delivery; // "30",
  final String no_of_product; // "1",
  final String coupons_discount; // "0",
  final String cart_total_amount; // "150.00"

  CartData(
      {this.cart_mrp,
      this.cart_saving,
      this.cart_delivery,
      this.no_of_product,
      this.coupons_discount,
      this.cart_total_amount,
      this.cartOwner,
      this.cartProducts,
      this.cartPrice});

  factory CartData.fromJson(Response<dynamic> response) {
    List<CartData> cartDataList = [];
    List<CartProduct> cartProductList = [];
    CartData cartData;
    response.data.forEach((data) {
      data['product'].forEach((data) {
        cartProductList.add(CartProduct.getProduct(data));
      });
      cartData = CartData.getProduct(data);
      cartDataList.add(cartData);
    });
    return new CartData(
      cartOwner: cartDataList[0].cartOwner,
      cartProducts: cartProductList,
      cartPrice: cartDataList[0].cartPrice,
      cart_delivery: cartData.cart_delivery,
      cart_mrp: cartData.cart_mrp,
      cart_saving: cartData.cart_saving,
      cart_total_amount: cartData.cart_total_amount,
      coupons_discount: cartData.coupons_discount,
      no_of_product: cartData.no_of_product,
    );
  }

  factory CartData.getProduct(dynamic data) {
    return CartData(
      cartOwner: data['cart_owner_id'],
      cartProducts: null,
      cartPrice: data['cart_price'],
      cart_delivery: data['cart_delivery'],
      cart_mrp: data['cart_mrp'],
      cart_saving: data['cart_saving'],
      cart_total_amount: data['cart_total_amount'],
      coupons_discount: data['coupons_discount'],
      no_of_product: data['no_of_product'],
    );
  }
}

class CartProduct {
  final int productId;
  final String productName;
  final String productPrice;

  final String product_image; // "uploads/products/803020001-001_ZBRDs5u.jpg",
  final String product_discountoff; // "5",
  final bool product_isavailable; // true,
  final String product_mrp; // "150.00",
  final bool product_isExchangeable; // true,
  final bool product_isReturnable; // true

  CartProduct(
      {this.product_image,
      this.product_discountoff,
      this.product_isavailable,
      this.product_mrp,
      this.product_isExchangeable,
      this.product_isReturnable,
      this.productId,
      this.productName,
      this.productPrice});

  factory CartProduct.getProduct(dynamic data) {
    return CartProduct(
      productId: data['product_id'],
      productName: data['product_name'],
      productPrice: data['product_price'],
      product_image: urlToAppend + data['product_image'],
      product_discountoff: data['product_discountoff'],
      product_isavailable: data['product_isavailable'],
      product_mrp: data['product_mrp'],
      product_isExchangeable: data['product_isExchangeable'],
      product_isReturnable: data['product_isReturnable'],
    );
  }
}

class MyOrderData {
  final String order_id;
  final String order_placed_by;
  final String ordered_products;

  final String total_products; // "uploads/products/803020001-001_ZBRDs5u.jpg",
  final String order_price;
  // "5",
  final String date_of_ordering; // true,
  final String date_of_delivery; // "150.00",
  final AddressData address; // true,
  // final String address; // true,
  final bool order_completed; // true

  MyOrderData(
      {this.order_id,
      this.order_placed_by,
      this.ordered_products,
      this.total_products,
      this.order_price,
      this.date_of_ordering,
      this.date_of_delivery,
      this.address,
      this.order_completed});

  factory MyOrderData.getProduct(dynamic data) {
    dynamic address = data['address'].split(":");
    print("Address data" + address.length.toString());
    // dynamic address = jsonDecode(data["address"]);

    return MyOrderData(
        order_id: data['order_id'].toString(),
        order_placed_by: data['order_placed_by']?.toString(),
        ordered_products: data['ordered_products']?.toString() ?? '',
        total_products: data['total_products']?.toString() ?? '',
        order_price: data['order_price']?.toString() ?? '',
        date_of_ordering: data['date_of_ordering']?.toString() ?? '',
        date_of_delivery: data['date_of_delivery']?.toString() ?? '',
        // address: data['address']?.toString() ?? '',
        address: AddressData(
          name: address[0],
          city: address[1],
          line1: data[2],
          line2: address[3],
          line3: address[4],
          addtype: address[5],
          addpincode: address[6].toString(),
        ),
        order_completed: data['order_completed']);
  }
}

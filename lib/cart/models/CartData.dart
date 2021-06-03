import 'package:dio/dio.dart';

class CartData {
  final String cartOwner;
  final List<CartProduct> cartProducts;
  final String cartPrice;

  CartData({this.cartOwner, this.cartProducts, this.cartPrice});

  factory CartData.fromJson(Response<dynamic> response) {
    List<CartData> cartDataList = [];
    List<CartProduct> cartProductList = [];
    response.data.forEach((data) {
      data['product'].forEach((data) {
        cartProductList.add(CartProduct.getProduct(data));
      });
      CartData cartData = CartData.getProduct(data);
      cartDataList.add(cartData);
    });
    return new CartData(
      cartOwner: cartDataList[0].cartOwner,
      cartProducts: cartProductList,
      cartPrice: cartDataList[0].cartPrice,
    );
  }

  factory CartData.getProduct(dynamic data) {
    return CartData(
      cartOwner: data['cart_owner_id'],
      cartProducts: null,
      cartPrice: data['cart_price'],
    );
  }
}

class CartProduct {
  final int productId;
  final String productName;
  final String productPrice;

  CartProduct({this.productId, this.productName, this.productPrice});

  factory CartProduct.getProduct(dynamic data) {
    return CartProduct(
      productId: data['product_id'],
      productName: data['product_name'],
      productPrice: data['product_price'],
    );
  }
}

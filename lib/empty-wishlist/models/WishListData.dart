import 'package:dio/dio.dart';

class WishlistData {
  final String wishlistOwner;
  final List<WishlistProduct> wishlistProducts;

  WishlistData({this.wishlistOwner, this.wishlistProducts,});

  factory WishlistData.fromJson(Response<dynamic> response) {
    List<WishlistData> wishlistDataList = [];
    List<WishlistProduct> wishlistProductList = [];
    response.data.forEach((data) {
      data['product'].forEach((data) {
        wishlistProductList.add(WishlistProduct.getProduct(data));
      });
      WishlistData wishlistData = WishlistData.getProduct(data);
      wishlistDataList.add(wishlistData);
    });
    return new WishlistData(
      wishlistOwner: wishlistDataList[0].wishlistOwner,
      wishlistProducts: wishlistProductList,
    );
  }

  factory WishlistData.getProduct(dynamic data) {
    return WishlistData(
      wishlistOwner: data['wishlist_owner_id'],
      wishlistProducts: null,
    );
  }
}

class WishlistProduct {
  final int productId;
  final String productName;
  final String productPrice;

  WishlistProduct({this.productId, this.productName, this.productPrice});

  factory WishlistProduct.getProduct(dynamic data) {
    return WishlistProduct(
      productId: data['product_id'],
      productName: data['product_name'],
      productPrice: data['product_price'],
    );
  }
}

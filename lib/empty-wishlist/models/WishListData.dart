import 'package:dio/dio.dart';

String urlToAppend = "https://swaraj.pythonanywhere.com/media/";

class WishlistData {
  final String wishlistOwner;
  final List<WishlistProduct> wishlistProducts;

  WishlistData({
    this.wishlistOwner,
    this.wishlistProducts,
  });

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

  final String product_image; // "uploads/products/803020001-001_ZBRDs5u.jpg",
  final String product_discountoff; // "5",
  final bool product_isavailable; // true,
  final String product_mrp; // "150.00",

  WishlistProduct(
      {this.product_image,
      this.product_discountoff,
      this.product_isavailable,
      this.product_mrp,
      this.productId,
      this.productName,
      this.productPrice});

  factory WishlistProduct.getProduct(dynamic data) {
    return WishlistProduct(
      productId: data['product_id'],
      productName: data['product_name'],
      productPrice: data['product_price'],
      product_image: urlToAppend + data['product_image'],
      product_discountoff: data['product_discountoff'],
      product_isavailable: data['product_isavailable'],
      product_mrp: data['product_mrp'],
    );
  }
}

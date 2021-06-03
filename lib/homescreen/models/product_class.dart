import 'package:dio/dio.dart';

String urlToAppend = "https://swaraj.pythonanywhere.com";

class ProductData {
  final int id;
  final String title;
  final String slug;
  final String desp;
  final String price;
  final String mrp;
  final String gst;
  final String discount_per;
  final String img;
  final String img1;
  final String img2;
  final String img3;
  final String thumbnail;
  final String dateadded;
  final String pub_date;
  final String edition;
  final String medium;
  final String label;
  final bool instock;
  final bool isExchnageable;
  final bool isReturnable;
  final bool isBestSeller;
  final bool isDealoftheday;
  final int Category;
  final int subCategory;
  final int category_id;
  final String catId;
  final String subCatId;

  ProductData(
      {this.id,
      this.title,
      this.slug,
      this.desp,
      this.price,
      this.mrp,
      this.gst,
      this.discount_per,
      this.img,
      this.img1,
      this.img2,
      this.img3,
      this.thumbnail,
      this.dateadded,
      this.pub_date,
      this.edition,
      this.medium,
      this.label,
      this.instock,
      this.isExchnageable,
      this.isReturnable,
      this.isBestSeller,
      this.isDealoftheday,
      this.Category,
      this.subCategory,
      this.category_id,
      this.catId,
      this.subCatId});

  FormData getFormData(ProductData product) {
    return FormData.fromMap({
      'category_id': product.category_id,
      'cat': product.catId,
      'sub_cat': product.subCatId,
      'medium': product.medium
    });
  }

  factory ProductData.getProduct(dynamic data) {
    return ProductData(
      id: data['id'],
      title: data['title'],
      slug: data['slug'],
      desp: data['desp'],
      price: data['price'],
      mrp: data['mrp'],
      gst: data['gst'],
      discount_per: data['discount_per'],
      img: data['img'] == null ? "" : urlToAppend + data['img'],
      img1: data['img1'] == null ? "" : urlToAppend + data['img1'],
      img2: data['img2'] == null ? "" : urlToAppend + data['img2'],
      img3: data['img3'] == null ? "" : urlToAppend + data['img3'],
      thumbnail: data['thumbnail'],
      dateadded: data['dateadded'],
      pub_date: data['pub_date'],
      edition: data['edition'],
      medium: data['medium'],
      label: data['label'],
      instock: data['instock'],
      isExchnageable: data['isExchnageable'],
      isReturnable: data['isReturnable'],
      isBestSeller: data['isBestSeller'],
      isDealoftheday: data['isDealoftheday'],
      Category: data['Category'],
      subCategory: data['subCategory'],
      category_id: data['category_id'],
      catId: data['cat'],
      subCatId: data['sub_cat'],
    );
  }

  List<ProductData> getProducts(Response<dynamic> response) {
    List<ProductData> proList = [];

    response.data.forEach((data) {
      ProductData product = ProductData.getProduct(data);
      proList.add(product);
    });
    return proList;
  }
}

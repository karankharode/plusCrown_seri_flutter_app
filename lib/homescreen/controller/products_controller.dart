import 'package:dio/dio.dart';
import 'package:seri_flutter_app/common/shared_pref.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';

class ProductController {
  static final _sharedPref = SharedPref.instance;
  final dio = Dio();

  Future<List<ProductData>> getProductBySubCategory(ProductData productData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/get_product_by_subcat/";
    final parameters = productData.getFormData(productData);

    List<ProductData> productsList =
        await _httpPostRequestForGetProductsByCategory(endPointUrl, parameters);
    return productsList;
  }

  Future<List<ProductData>> getProductByKeyword(String keyword) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/search/";
    final parameters = ProductData().getKeyword(keyword);

    List<ProductData> productsList =
        await _httpPostRequestForGetProductsByCategory(endPointUrl, parameters);
    return productsList;
  }

  Future<List<ProductData>> getProductByMedium(ProductData productData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/get_product_by_medium/";
    final parameters = productData.getFormData(productData);

    List<ProductData> productsList =
        await _httpPostRequestForGetProductsByCategory(endPointUrl, parameters);
    return productsList;
  }

  Future<List<ProductData>> getProductByCategory(ProductData productData) async {
    const endPointUrl = "https://swaraj.pythonanywhere.com/django/api/get_products_by_category/";
    final parameters = productData.getFormData(productData);

    List<ProductData> productsList =
        await _httpPostRequestForGetProductsByCategory(endPointUrl, parameters);
    return productsList;
  }

  Future<List<ProductData>> _httpPostRequestForGetProductsByCategory(
      String url, FormData formData) async {
    List<ProductData> productList;

    try {
      var response = await dio.post(url, data: formData);
      productList = ProductData().getProducts(response);
      if (response != null && productList != null) {
        return productList;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

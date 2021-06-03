import 'package:dio/dio.dart';
import 'package:seri_flutter_app/homescreen/models/category_class.dart';

class CategoryController {
  final dio = Dio();

  Future<List<CategoryData>> getCategory() async {
    const endPointUrl = "http://swaraj.pythonanywhere.com/django/api/get_category";

    List<CategoryData> categoryList = await _httpPostRequestForGetCategory(endPointUrl);
    return categoryList;
  }

  Future<List<CategoryData>> _httpPostRequestForGetCategory(
    String url,
  ) async {
    List<CategoryData> categoryList;

    try {
      var response = await dio.get(
        url,
      );
      categoryList = CategoryData().getCategories(response);
      if (response != null && categoryList != null) {
        return categoryList;
      } else {
        return null;
      }
    } catch (e) {
      throw new Exception('Error');
    }
  }
}

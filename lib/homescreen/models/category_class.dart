import 'package:dio/dio.dart';

String urlToAppend = "https://swaraj.pythonanywhere.com";
// ignore_for_file: non_constant_identifier_names
class CategoryData {
  final int id;
  final String name;
  final String slug;
  final String cat_ban;

  CategoryData({this.id, this.name, this.slug, this.cat_ban});

  // FormData getFormData(CategoryData category) {
  //   return FormData.fromMap({
  //     'category_id': category.category_id,
  //     'cat': category.catId,
  //     'sub_cat': category.subCatId,
  //     'medium': category.medium
  //   });
  // }

  factory CategoryData.getCategory(dynamic data) {
    return CategoryData(
      id: data['id'],
      name: data['name'],
      slug: data['slug'],
      cat_ban: data['cat_ban'],
    );
  }

  List<CategoryData> getCategories(Response<dynamic> response) {
    List<CategoryData> proList = [];

    response.data.forEach((data) {
      CategoryData product = CategoryData.getCategory(data);
      proList.add(product);
    });
    return proList;
  }
}

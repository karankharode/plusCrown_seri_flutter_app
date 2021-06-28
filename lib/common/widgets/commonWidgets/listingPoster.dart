import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/homescreen/models/category_class.dart';

String urlToAppend = "https://swaraj.pythonanywhere.com";

Container buildListingPoster(BuildContext context, String assetName, String catId) {
  CategoryData category = globalCategoryData.firstWhere((element) {
    if (element.id.toString() == catId)
      return true;
    else
      return false;
  });
  return Container(
      margin: EdgeInsets.all(2),
      width: MediaQuery.of(context).size.width,
      child: Image.network(
        urlToAppend + category.cat_ban,
        errorBuilder: (BuildContext context, o, s) {
          return Lottie.asset(
            'assets/animations/404Animation.json',
            // width: 180,
            height: 90,
            fit: BoxFit.scaleDown,
          );
        },
        frameBuilder: (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded) {
          return Padding(
            padding: EdgeInsets.all(0.0),
            child: child,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Lottie.asset(
            'assets/animations/imageLoader.json',
            // width: 180,
            height: 90,
            fit: BoxFit.scaleDown,
          );
        },
      )
      // child: Image.asset(assetName),
      );
}

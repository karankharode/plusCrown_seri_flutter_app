import 'package:flutter/material.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/horizontalProductList.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/titleAndShowAllButton.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';

FutureBuilder<dynamic> subcategoryBuilder(
    loginResponse, cartData, context, Size size, future, String subCattitle, catId, subCatId) {
  return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
          case ConnectionState.active:
            return Container();
          case ConnectionState.done:
            if (snapshot.hasData) {
              List<ProductData> proList = snapshot.data;
              if (proList.length > 0) {
                return Column(
                  children: [
                    buildTitleandShowAllRow(
                        context, subCattitle, loginResponse, cartData, catId, subCatId,future: future),
                    (subCattitle.split('-').first == "Combos")
                        ? buildHorizontalCombosList(size, proList, loginResponse, cartData)
                        : buildHorizontalProductList(size, proList, loginResponse, cartData),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
            break;
          default:
            return Container();
        }
      });
}

Column buildCategoryProductList(
  BuildContext context,
  Size size,
  List<ProductData> proList,
  title,
  catId,
  subCatId,
  loginResponse,
  cartData,
) {
  return Column(
    children: [
      buildTitleandShowAllRow(context, title, loginResponse, cartData, catId, subCatId),
      buildHorizontalProductList(size, proList, loginResponse, cartData),
      SizedBox(height: 15),
    ],
  );
}

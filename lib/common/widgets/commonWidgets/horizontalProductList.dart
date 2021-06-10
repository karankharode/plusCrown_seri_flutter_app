import 'package:flutter/material.dart';
import 'package:seri_flutter_app/homescreen/data/product_list.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/listing-pages/screens/combosCard.dart';

Container buildHorizontalProductList(
    Size size, List<ProductData> proList, loginResponse, cartData) {
  return Container(
    height: size.height * 0.33,
    child: ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: proList.length,
      itemBuilder: (context, int index) {
        ProductData product = proList[index];
        return ProductList(product, loginResponse, cartData);
      },
    ),
  );
}

Container buildHorizontalCombosList(Size size, List<ProductData> proList, loginResponse, cartData) {
  return Container(
    height: size.height * 0.42,
    child: ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: proList.length,
      itemBuilder: (context, int index) {
        ProductData product = proList[index];

        return comboCard(cartData: cartData,index: index,loginResponse: loginResponse,productData: product,);
      },
    ),
  );
}

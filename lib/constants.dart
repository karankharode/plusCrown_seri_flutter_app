import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/homescreen/models/category_class.dart';
import 'package:sizer/sizer.dart';

const kPrimaryColor = Color.fromARGB(255, 71, 54, 111);
const double kDefaultPadding = 20.0;
// const kDefaultBorderRadius = BorderRadius.circular(10)

TextStyle textStyle = TextStyle(
  fontFamily: 'GothamMedium',
  fontSize: 2.2.h,
  fontWeight: FontWeight.w400,
  color: kPrimaryColor,
);
TextStyle heading = TextStyle(
  fontFamily: 'GothamMedium',
  fontSize: 2.3.h,
  fontWeight: FontWeight.w800,
  color: kPrimaryColor,
);

List<CategoryData> globalCategoryData = [];
CartData globalCartData;

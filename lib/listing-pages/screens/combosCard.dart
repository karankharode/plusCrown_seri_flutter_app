import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/homescreen/others/page_one.dart';
import 'package:sizer/sizer.dart';

Widget combosCard(BuildContext context, int index, ProductData productData,  loginResponse, cartData) {
  bool wishlist = false;
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).push(commonRouter(PageOne(productData, loginResponse, cartData)));
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 1, color: Color(0x99999999), spreadRadius: 0.5, offset: Offset(1, 1))
          ],
          color: Colors.white,
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(20),
        ),
        width: 180,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  productData.label != null
                      ? Container(
                          decoration: BoxDecoration(
                              color: productData.label == 'P' ? Colors.green : Colors.red),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 5),
                            child: Text(
                              productData.label,
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Colors.white,
                                fontSize: 7.sp,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Spacer(),
                  Container(
                    // height: 3.h,
                    child: wishlist == true
                        ? Image.asset(
                            'assets/images/wishlisted.png',
                            width: MediaQuery.of(context).size.width * 0.08,
                          )
                        : Image.asset(
                            'assets/images/wishlist.png',
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                height: 100,
                width: 150,
                child: CachedNetworkImage(
                  imageUrl: productData.img,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Text(
                productData.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  // fontSize: size.width * 0.03,
                  fontFamily: 'GothamMedium',
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  // color: Color.fromARGB(255, 71, 54, 111),
                ),
              ),
              Text.rich(
                productData.discount_per != ""
                    ? TextSpan(
                        children: [
                          TextSpan(
                              text: '\u20B9 ${productData.price} ',
                              style:
                                  TextStyle(fontFamily: 'GothamMedium', fontWeight: FontWeight.w900)),
                          TextSpan(
                            text: '${productData.mrp}',
                            style: TextStyle(
                                fontFamily: 'GothamMedium', decoration: TextDecoration.lineThrough),
                          ),
                          TextSpan(
                            text: '(${productData.discount_per}%)',
                            style: TextStyle(fontFamily: 'GothamMedium', color: Colors.green),
                          ),
                        ],
                      )
                    : TextSpan(text: '\u20B9 ${productData.price}'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'GothamMedium',
                  color: Color.fromARGB(255, 71, 54, 111),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

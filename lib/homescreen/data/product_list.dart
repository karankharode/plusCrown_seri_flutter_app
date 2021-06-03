import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/homescreen/others/page_one.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class ProductList extends StatefulWidget {
  final ProductData myProduct;
  final LoginResponse loginResponse;
  final CartData cartData;

  const ProductList(this.myProduct, this.loginResponse, this.cartData);

  @override
  _ProductListState createState() => _ProductListState(loginResponse, cartData, myProduct);
}

class _ProductListState extends State<ProductList> {
  final ProductData myProduct;
  final LoginResponse loginResponse;
  final CartData cartData;

  _ProductListState(this.loginResponse, this.cartData, this.myProduct);

  @override
  void initState() {
    super.initState();
  }

  bool wishlist = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(commonRouter(PageOne(myProduct, loginResponse, cartData)));
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 8,
          bottom: kDefaultPadding / 5,
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2,
        ),
        // height: size.height / 10,
        width: size.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                blurRadius: 1, color: Color(0x99999999), spreadRadius: 0.5, offset: Offset(1, 1))
          ],
          border: Border.all(
            color: kPrimaryColor.withOpacity(0.5),
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(top: kDefaultPadding / 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(kDefaultPadding * 0.11),
                    height: 20,
                    decoration: BoxDecoration(
                      color: myProduct.slug == 'S' ? Colors.red : Colors.green,
                    ),
                    child: Center(
                      child: Text(
                        "Trending",
                        style: TextStyle(
                          fontSize: 8.0.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        wishlist = wishlist == false ? true : false;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: kDefaultPadding / 2.7),
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
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height / 175),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1
                  // vertical: kDefaultPadding / 2
                  ),
              child: Container(
                height: size.height * 0.18,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kPrimaryColor.withOpacity(0.5),
                  ),
                ),
                // child: widget.myProduct.img != null? Image.asset(widget.myProduct.img, fit: BoxFit.fill,): Container()
                child: CachedNetworkImage(
                  imageUrl: myProduct.img,
                  errorWidget: (context, url, error) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.error),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height / 115),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: EdgeInsets.fromLTRB(10, 0, 2, 0),
                  child: Center(
                    child: Text(
                      myProduct.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: size.width * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '\u20B9 ',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.03,
                    ),
                    children: [
                      TextSpan(
                        text: "${myProduct.price} ",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.035,
                        ),
                      ),
                      TextSpan(
                        text: "${myProduct.mrp.toString()} ",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.normal,
                          fontSize: size.width * 0.025,
                        ),
                      ),
                      TextSpan(
                        text: "(${myProduct.discount_per.toString()}%)",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height / 155),
          ],
        ),
      ),
    );
  }
}

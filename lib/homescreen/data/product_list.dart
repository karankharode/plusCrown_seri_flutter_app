import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/networkImageBuilder.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/showFlushBar.dart';
import 'package:seri_flutter_app/empty-wishlist/controller/wishListController.dart';
import 'package:seri_flutter_app/empty-wishlist/models/AddtoWishlistData.dart';
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

  var box;
  List favList = [];

  initHive() async {
    box = await Hive.openBox('favBox');
    List localFavList = box.get('favList');
    if (localFavList != null) favList = localFavList;
  }

  addToFavList(productId) {
    favList.add(productId.toString());
    box.put('favList', favList.toList());
    setState(() {
      favList = box.get('favList');
    });
  }

  removeFromFavList(productId) {
    favList.remove(productId.toString());
    box.put('favList', favList.toList());
    favList = box.get('favList');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initHive();
  }

  bool wishlist = false;

  addToWishList(productId) async {
    setState(() {
      wishlist = true;
    });
    bool response = await WishlistController()
        .addToWishlist(AddToWishlistData(customerId: loginResponse.id, productId: productId));
    setState(() {
      wishlist = response;
    });
    if (response) {
      addToFavList(productId);
      showCustomFlushBar(context, "Added Successfully", 2);
    } else {
      showCustomFlushBar(context, "Error Adding to WishList", 2);
    }
  }

  removeFromWishList(productId) async {
    setState(() {
      wishlist = false;
    });
    bool response = await WishlistController()
        .removeFromWishlist(AddToWishlistData(customerId: loginResponse.id, productId: productId));
    setState(() {
      wishlist = !response;
    });
    if (response) {
      removeFromFavList(productId);
      showCustomFlushBar(context, "Removed Product", 2);
    } else {
      showCustomFlushBar(context, "Error removing from WishList", 2);
    }
  }

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
                      if (wishlist == false || favList.contains(myProduct.id.toString()))
                        addToWishList(myProduct.id);
                      else
                        removeFromWishList(myProduct.id);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: kDefaultPadding / 2.7),
                      child: wishlist == true || favList.contains(myProduct.id.toString())
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
                    // border: Border.all(
                    //   color: kPrimaryColor.withOpacity(0.5),
                    // ),
                    ),
                // child: widget.myProduct.img != null? Image.asset(widget.myProduct.img, fit: BoxFit.fill,): Container()
                child: coverPageimageBuilder(myProduct.img),
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

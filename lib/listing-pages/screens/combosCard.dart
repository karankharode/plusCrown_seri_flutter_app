import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/showFlushBar.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/empty-wishlist/controller/wishListController.dart';
import 'package:seri_flutter_app/empty-wishlist/models/AddtoWishlistData.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/homescreen/others/page_one.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

class comboCard extends StatefulWidget {
  final int index;
  final ProductData productData;
  final LoginResponse loginResponse;
  final CartData cartData;

  const comboCard({this.index, this.productData, this.loginResponse, this.cartData});
  @override
  _comboCardState createState() => _comboCardState();
}

class _comboCardState extends State<comboCard> {
  bool wishlist = false;

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

  addToWishList(productId) async {
    setState(() {
      wishlist = true;
    });
    bool response = await WishlistController().addToWishlist(
        AddToWishlistData(customerId: widget.loginResponse.id, productId: productId));
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
    bool response = await WishlistController().removeFromWishlist(
        AddToWishlistData(customerId: widget.loginResponse.id, productId: productId));
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
    double width = MediaQuery.of(context).size.width / 1.5;
    print(widget.productData.label);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              commonRouter(PageOne(widget.productData, widget.loginResponse, widget.cartData)));
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
          width: width + 10,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    widget.productData.label != "S"
                        ? Container(
                            decoration: BoxDecoration(
                                color: widget.productData.label == 'P' ? Colors.green : Colors.red),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
                              child: Text(
                                widget.productData.label == 'P' ? "Trending" : "New",
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
                    GestureDetector(
                      onTap: () {
                        if (wishlist == false)
                          addToWishList(widget.productData.id);
                        else
                          removeFromWishList(widget.productData.id);
                      },
                      child: Container(
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
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    // height: width / 1.5,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: widget.productData.img,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(3, 5, 3, 5),
                  child: Text(
                    widget.productData.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontSize: size.width * 0.03,
                      fontFamily: 'GothamMedium',
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      // color: Color.fromARGB(255, 71, 54, 111),
                    ),
                  ),
                ),
                Text.rich(
                  widget.productData.discount_per != ""
                      ? TextSpan(
                          children: [
                            TextSpan(
                                text: '\u20B9 ${widget.productData.price} ',
                                style: TextStyle(
                                    fontFamily: 'GothamMedium', fontWeight: FontWeight.w900)),
                            TextSpan(
                              text: '${widget.productData.mrp}',
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  decoration: TextDecoration.lineThrough),
                            ),
                            TextSpan(
                              text: '(${widget.productData.discount_per}%)',
                              style: TextStyle(fontFamily: 'GothamMedium', color: Colors.green),
                            ),
                          ],
                        )
                      : TextSpan(text: '\u20B9 ${widget.productData.price}'),
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
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/common/widgets/appBars/buildAppBarWithSearch.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/listingPoster.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/subCategoryBuilder.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

import '../../constants.dart';

class Competitive extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Competitive(this.loginResponse, this.cartData);

  @override
  _CompetitiveState createState() =>
      _CompetitiveState(loginResponse: loginResponse, cartData: cartData);
}

class _CompetitiveState extends State<Competitive> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _CompetitiveState({this.loginResponse, this.cartData});

  var productController;
  Future futureForJEEProducts;
  Future futureForNEETProducts;
  Future futureForCETProducts;

  var cartController;

  bool fetched = false;
  getFetchedStatus(future) {
    future.then((value) {
      setState(() {
        fetched = true;
      });
    });
  }

  @override
  void initState() {
    productController = Provider.of<ProductController>(context, listen: false);
    cartController = Provider.of<CartController>(context, listen: false);
    futureForJEEProducts =
        productController.getProductBySubCategory(new ProductData(catId: "6", subCatId: "5"));
    futureForNEETProducts =
        productController.getProductBySubCategory(new ProductData(catId: "6", subCatId: "6"));
    futureForCETProducts =
        productController.getProductBySubCategory(new ProductData(catId: "6", subCatId: "14"));
    getFetchedStatus(futureForCETProducts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool search = false;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: search == false
            ? buildAppBarWithSearch(context, loginResponse, () {
                setState(() {
                  search = true;
                });
              })
            : null,
        drawer: CustomDrawer(loginResponse, cartData),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            search == true
                ? Stack(
                    children: <Widget>[
                      Container(
                        height: size.height * 0.1,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                        ),
                      ),
                      Positioned(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                            vertical: kDefaultPadding * 0.8,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 0.5,
                          ),
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: kDefaultPadding,
                                ),
                                child: Image.asset(
                                  'assets/images/search.png',
                                  width: size.width * 0.06,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    // contentPadding:
                                    //     EdgeInsets.only(top: kDefaultPadding * 0.05),
                                    hintText: "SEARCH PRODUCTS",
                                    hintStyle: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      color: kPrimaryColor.withOpacity(0.5),
                                    ),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    search = false;
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/cross_purple.png',
                                  width: size.width * 0.06,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Container(
                    height: 0.0,
                    width: 0.0,
                  ),
            buildListingPoster(context, 'assets/images/competitive.png',"6"),
            fetched
                ? Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(top: kDefaultPadding / 2),
                      physics: BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        subcategoryBuilder(loginResponse, cartData, context, size,
                            futureForJEEProducts, 'Prepare for JEE', "6", "5"),
                        subcategoryBuilder(loginResponse, cartData, context, size,
                            futureForNEETProducts, 'Prepare for NEET', "6", "6"),
                        subcategoryBuilder(loginResponse, cartData, context, size,
                            futureForCETProducts, 'Prepare for CET', "6", "14"),
                      ],
                    ),
                  )
                : bookLoader(),
          ],
        ),
      ),
    );
  }
}

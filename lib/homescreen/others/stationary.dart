import 'package:seri_flutter_app/common/widgets/appBars/buildAppBarWithSearch.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/listingPoster.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/subCategoryBuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import '../../constants.dart';


class Stationary extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Stationary({this.loginResponse, this.cartData});

  @override
  _StationaryState createState() =>
      _StationaryState(loginResponse: loginResponse, cartData: cartData);
}

class _StationaryState extends State<Stationary> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _StationaryState({this.loginResponse, this.cartData});

  var productController;
  Future futureForPens;
  Future futureForDrawingMaterials;
  Future futureForOther;

  bool search = false;
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
    futureForPens =
        productController.getProductBySubCategory(new ProductData(catId: "7", subCatId: "9"));
    futureForDrawingMaterials =
        productController.getProductBySubCategory(new ProductData(catId: "7", subCatId: "24"));
    futureForOther =
        productController.getProductBySubCategory(new ProductData(catId: "7", subCatId: "25"));
    getFetchedStatus(futureForOther);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Color.fromARGB(255, 71, 54, 111),
      child: SafeArea(
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
              SizedBox(
                height: 2,
              ),
              buildListingPoster(context, 'assets/stationary/stationary.png',"7"),
              SizedBox(
                height: 5,
              ),
              fetched
                  ? Expanded(
                      child: ListView(
                        padding: EdgeInsets.only(top: kDefaultPadding / 2),
                        physics: BouncingScrollPhysics(),
                        children: [
                          subcategoryBuilder(loginResponse, cartData, context, size, futureForPens,
                              "Pens", "7", "9"),
                          subcategoryBuilder(loginResponse, cartData, context, size,
                              futureForDrawingMaterials, "Drawing Materials", "7", "24"),
                          subcategoryBuilder(loginResponse, cartData, context, size, futureForOther,
                              "Other Stationary", "7", "25"),
                        ],
                      ),
                    )
                  : bookLoader(),
            ],
          ),
        ),
      ),
    );
  }
}
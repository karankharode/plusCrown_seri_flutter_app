import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/common/widgets/appBars/buildAppBarWithSearch.dart';
import 'package:seri_flutter_app/common/widgets/appBars/searchBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/listingPoster.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/subCategoryBuilder.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

import '../../constants.dart';

class Story extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Story(this.loginResponse, this.cartData);

  @override
  _StoryState createState() => _StoryState(loginResponse: loginResponse, cartData: cartData);
}

class _StoryState extends State<Story> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _StoryState({this.cartData, this.loginResponse});

  var productController;

  Future futureForKids;
  Future futureForAdults;
  Future futureForBooksInMarathi;
  Future futureForBooksInHindi;
  Future futureForBestSellers;
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
    futureForKids =
        productController.getProductBySubCategory(new ProductData(catId: "10", subCatId: "15"));
    futureForAdults =
        productController.getProductBySubCategory(new ProductData(catId: "10", subCatId: "16"));
    futureForBooksInMarathi =
        productController.getProductBySubCategory(new ProductData(catId: "10", subCatId: "17"));
    futureForBooksInHindi =
        productController.getProductBySubCategory(new ProductData(catId: "10", subCatId: "18"));
    futureForBestSellers =
        productController.getProductBySubCategory(new ProductData(catId: "10", subCatId: "19"));

    getFetchedStatus(futureForBestSellers);
    super.initState();
  }

  int _counter = 0;

  bool search = false;
  @override
  Widget build(BuildContext context) {
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
                ? buildSearchBar(
                    context,
                    size,
                    () {
                      setState(() {
                        search = false;
                      });
                    }, loginResponse, cartData
                  )
                : Container(),
            SizedBox(
              height: 3,
            ),
            buildListingPoster(context, 'assets/images/story_books.png', "10"),
            fetched
                ? Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(top: kDefaultPadding / 2),
                      physics: BouncingScrollPhysics(),
                      children: [
                        subcategoryBuilder(loginResponse, cartData, context, size, futureForKids,
                            "For Kids", "10", "15"),
                        subcategoryBuilder(loginResponse, cartData, context, size, futureForAdults,
                            "For Adults", "10", "16"),
                        subcategoryBuilder(loginResponse, cartData, context, size,
                            futureForBooksInMarathi, "Books in Marathi", "10", "17"),
                        subcategoryBuilder(loginResponse, cartData, context, size,
                            futureForBooksInHindi, "Books in Hindi", "10", "18"),
                        subcategoryBuilder(loginResponse, cartData, context, size,
                            futureForBestSellers, "Best Sellers", "10", "19"),
                        // int bestSell = 0;
                        //         List<ProductData> proList = snapshot.data;
                        //         for (ProductData prod in proList) {
                        //           if (prod.isBestSeller == true) {
                        //             bestSell++;
                        //           }
                        //         }
                        //         if (bestSell > 0) {return here;}
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

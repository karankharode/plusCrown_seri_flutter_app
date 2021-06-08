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

class Biography extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Biography({this.loginResponse, this.cartData});

  @override
  _BiographyState createState() =>
      _BiographyState(loginResponse: loginResponse, cartData: cartData);
}

class _BiographyState extends State<Biography> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _BiographyState({this.loginResponse, this.cartData});

  var productController;
  Future futureForActors;
  Future futureForActivists;
  Future futureForEntertainers;

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
    futureForEntertainers =
        productController.getProductBySubCategory(new ProductData(catId: "9", subCatId: "20"));
    futureForActors =
        productController.getProductBySubCategory(new ProductData(catId: "9", subCatId: "21"));
    futureForActivists =
        productController.getProductBySubCategory(new ProductData(catId: "9", subCatId: "22"));
    getFetchedStatus(futureForActivists);
    super.initState();
  }

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
                ? SearchBar(
                    context,
                    size,
                    () {
                      setState(() {
                        search = false;
                      });
                    }, loginResponse, cartData
                  )
                : Container(),
            buildListingPoster(context, 'assets/images/biography.png', "9"),
            fetched
                ? Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(top: kDefaultPadding / 2),
                      physics: BouncingScrollPhysics(),
                      children: [
                        subcategoryBuilder(loginResponse, cartData, context, size,
                            futureForEntertainers, "Biography about entertainers", "9", "20"),
                        subcategoryBuilder(loginResponse, cartData, context, size,
                            futureForActivists, "Biography about activists", "9", "22"),
                        subcategoryBuilder(loginResponse, cartData, context, size, futureForActors,
                            "Biography about actors", "9", "21"),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/common/widgets/appBars/buildAppBarWithSearch.dart';
import 'package:seri_flutter_app/common/widgets/appBars/searchBar.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/listingPoster.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/subCategoryBuilder.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';

class Books extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Books(this.loginResponse, this.cartData);

  @override
  _BooksState createState() => _BooksState(loginResponse: loginResponse, cartData: cartData);
}

class _BooksState extends State<Books> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _BooksState({this.loginResponse, this.cartData});

  var productController;
  Future futureForDiaryProducts;
  Future futureForLongBooksProducts;
  Future futureForProjectBooksProducts;

  bool fetched = false;
  bool search = false;
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
    futureForDiaryProducts =
        productController.getProductBySubCategory(new ProductData(catId: "8", subCatId: "11"));
    futureForLongBooksProducts =
        productController.getProductBySubCategory(new ProductData(catId: "8", subCatId: "10"));
    futureForProjectBooksProducts =
        productController.getProductBySubCategory(new ProductData(catId: "8", subCatId: "12"));
    getFetchedStatus(futureForProjectBooksProducts);
    super.initState();
  }

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
          children: [
            search == true
                ? SearchBar(context, size, () {
                    setState(() {
                      search = false;
                    });
                  }, loginResponse, cartData)
                : Container(),
            buildListingPoster(context, 'assets/images/book_gif.gif', "8"),
            fetched
                ? Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(top: kDefaultPadding / 2),
                      physics: BouncingScrollPhysics(),
                      children: [
                        subcategoryBuilder(loginResponse, cartData, context, size,
                            futureForDiaryProducts, "Diary", "4", "13"),
                        subcategoryBuilder(loginResponse, cartData, context, size,
                            futureForDiaryProducts, "Long Books", "4", "13"),
                        subcategoryBuilder(loginResponse, cartData, context, size,
                            futureForDiaryProducts, "Project Books", "4", "13"),
                        SizedBox(
                          height: 10,
                        )
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

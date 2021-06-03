import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/listingPoster.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/subCategoryBuilder.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

class BooksBody extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  BooksBody(this.loginResponse, this.cartData);

  @override
  _BooksBodyState createState() => _BooksBodyState(cartData, loginResponse);
}

class _BooksBodyState extends State<BooksBody> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _BooksBodyState(this.cartData, this.loginResponse);

  var productController;
  Future futureForDiaryProducts;
  Future futureForLongBooksProducts;
  Future futureForProjectBooksProducts;

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
    return Column(
      children: [
        buildListingPoster(context, 'assets/images/book_gif.gif',"8"),
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
    );
  }
}

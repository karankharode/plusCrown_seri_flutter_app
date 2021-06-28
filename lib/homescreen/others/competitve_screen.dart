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
import 'package:sizer/sizer.dart';

class Competitive extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Competitive(this.loginResponse, this.cartData);

  @override
  _CompetitiveState createState() =>
      _CompetitiveState(loginResponse: loginResponse, cartData: cartData);
}

class _CompetitiveState extends State<Competitive> with SingleTickerProviderStateMixin {
  final LoginResponse loginResponse;
  final CartData cartData;

  _CompetitiveState({this.loginResponse, this.cartData});

  var productController;
  Future futureForNEETProductsCat1;
  Future futureForNEETProductsCat2;
  Future futureForNEETProductsCat3;

  Future futureForJEEProductsCat1;
  Future futureForJEEProductsCat2;
  Future futureForJEEProductsCat3;

  Future futureForCETProductsCat1;
  Future futureForCETProductsCat2;
  Future futureForCETProductsCat3;
  Future futureForCETProductsCat4;

  var cartController;

  TabController _tabController;

  bool fetched = false;
  getFetchedStatus(future) {
    future.then((value) {
      setState(() {
        fetched = true;
      });
    });
  }

  bool search = false;

  @override
  void initState() {
    productController = Provider.of<ProductController>(context, listen: false);
    cartController = Provider.of<CartController>(context, listen: false);
    futureForNEETProductsCat1 =
        productController.getProductBySubCategory(new ProductData(catId: "6", subCatId: "28"));
    futureForNEETProductsCat2 =
        productController.getProductBySubCategory(new ProductData(catId: "6", subCatId: "27"));
    futureForNEETProductsCat3 =
        productController.getProductBySubCategory(new ProductData(catId: "6", subCatId: "26"));

    futureForJEEProductsCat1 =
        productController.getProductBySubCategory(new ProductData(catId: "6", subCatId: "29"));
    futureForJEEProductsCat2 =
        productController.getProductBySubCategory(new ProductData(catId: "6", subCatId: "27"));
    futureForJEEProductsCat3 =
        productController.getProductBySubCategory(new ProductData(catId: "6", subCatId: "26"));

    futureForCETProductsCat1 =
        productController.getProductBySubCategory(new ProductData(catId: "6", subCatId: "29"));
    futureForCETProductsCat2 =
        productController.getProductBySubCategory(new ProductData(catId: "6", subCatId: "28"));
    futureForCETProductsCat3 =
        productController.getProductBySubCategory(new ProductData(catId: "6", subCatId: "27"));
    futureForCETProductsCat4 =
        productController.getProductBySubCategory(new ProductData(catId: "6", subCatId: "26"));

    _tabController = new TabController(length: 3, vsync: this);

    getFetchedStatus(futureForNEETProductsCat3);
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
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                search == true
                    ? SearchBar(context, size, () {
                        setState(() {
                          search = false;
                        });
                      }, loginResponse, cartData)
                    : Container(),
                buildListingPoster(context, 'assets/images/competitive.png', "6"),
                Padding(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  child: TabBar(
                    indicatorColor: Color.fromARGB(255, 204, 0, 0),
                    indicatorWeight: 2,
                    labelColor: Color.fromARGB(255, 71, 54, 111),
                    labelStyle: TextStyle(
                        fontFamily: 'GothamMedium', fontSize: 12.sp, fontWeight: FontWeight.w500),
                    unselectedLabelColor: Color.fromARGB(255, 71, 54, 111),
                    labelPadding: EdgeInsets.all(0),
                    tabs: [
                      Tab(text: 'NEET'),
                      Tab(text: 'JEE'),
                      Tab(text: 'CET'),
                    ],
                    controller: _tabController,
                  ),
                ),
                SizedBox(height: 5),
                fetched
                    ? Expanded(
                        child: TabBarView(controller: _tabController, children: [
                          ListView(
                            padding: EdgeInsets.only(top: 5),
                            physics: BouncingScrollPhysics(),
                            children: [
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForNEETProductsCat1, 'Prepare for Biology', "6", "28"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForNEETProductsCat2, 'Prepare for Chemistry', "6", "27"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForNEETProductsCat3, 'Prepare for Physics', "6", "26"),
                              SizedBox(height: 14.h)
                            ],
                          ),
                          ListView(
                            padding: EdgeInsets.only(top: 5),
                            physics: BouncingScrollPhysics(),
                            children: [
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForJEEProductsCat1, 'Prepare for Mathematics', "6", "29"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForJEEProductsCat2, 'Prepare for Chemistry', "6", "27"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForJEEProductsCat3, 'Prepare for Physics', "6", "26"),
                              SizedBox(height: 14.h)
                            ],
                          ),
                          ListView(
                            padding: EdgeInsets.only(top: 5),
                            physics: BouncingScrollPhysics(),
                            children: [
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForCETProductsCat1, 'Prepare for Mathematics', "6", "29"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForCETProductsCat2, 'Prepare for Biology', "6", "28"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForCETProductsCat3, 'Prepare for Chemistry', "6", "27"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForCETProductsCat4, 'Prepare for Physics', "6", "26"),
                              SizedBox(height: 14.h)
                            ],
                          ),
                        ]),
                      )
                    : bookLoader(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

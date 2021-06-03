import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/common/widgets/appBars/buildAppBarWithSearch.dart';
import 'package:seri_flutter_app/common/widgets/appBars/cartwithBadge.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/horizontalProductList.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/listingPoster.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/subCategoryBuilder.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/titleAndShowAllButton.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class ListingPageForClasses extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;
  final bool above10th;
  final String catId;

  ListingPageForClasses({
    this.loginResponse,
    this.cartData,
    this.above10th,
    this.catId,
  });

  @override
  _ListingPageForClassesState createState() =>
      _ListingPageForClassesState(loginResponse: loginResponse, cartData: cartData);
}

class _ListingPageForClassesState extends State<ListingPageForClasses>
    with SingleTickerProviderStateMixin {
  final LoginResponse loginResponse;
  final CartData cartData;
  bool search = false;
  _ListingPageForClassesState({this.loginResponse, this.cartData});

  var productController;
  TabController _tabController;
  var wishlist = false;

  Future futureForTab1Subcat1;
  Future futureForTab1Subcat2;
  Future futureForTab1Subcat3;
  Future futureForTab1Subcat4;

  Future futureForTab2Subcat1;
  Future futureForTab2Subcat2;
  Future futureForTab2Subcat3;
  Future futureForTab2Subcat4;

  Future futureForTab3Subcat1;
  Future futureForTab3Subcat2;
  Future futureForTab3Subcat3;
  Future futureForTab3Subcat4;

  Map<String, String> categoryBannerMap = {
    "1": 'assets/icons/Story Books (3).png',
    "2": 'assets/icons/9th standard.png',
    "5": 'assets/icons/10th standard.gif',
    "3": 'assets/icons/11th Standard.png',
    "4": 'assets/icons/12th standard.gif',
  };

  bool fetched = false;
  getFetchedStatus() {
    futureForTab1Subcat4.then((value) {
      setState(() {
        fetched = true;
      });
    });
  }

  @override
  void initState() {
    productController = Provider.of<ProductController>(context, listen: false);

    futureForTab1Subcat1 = productController.getProductByMedium(new ProductData(
        catId: widget.catId, subCatId: "13", medium: widget.above10th ? "Science" : "English"));
    futureForTab1Subcat2 = productController.getProductByMedium(new ProductData(
        catId: widget.catId, subCatId: "1", medium: widget.above10th ? "Science" : "English"));
    futureForTab1Subcat3 = productController.getProductByMedium(new ProductData(
        catId: widget.catId, subCatId: "2", medium: widget.above10th ? "Science" : "English"));
    futureForTab1Subcat4 = productController.getProductByMedium(new ProductData(
        catId: widget.catId, subCatId: "4", medium: widget.above10th ? "Science" : "English"));

    futureForTab2Subcat1 = productController.getProductByMedium(new ProductData(
        catId: widget.catId, subCatId: "13", medium: widget.above10th ? "Commerce" : "Marathi"));
    futureForTab2Subcat2 = productController.getProductByMedium(new ProductData(
        catId: widget.catId, subCatId: "1", medium: widget.above10th ? "Commerce" : "Marathi"));
    futureForTab2Subcat3 = productController.getProductByMedium(new ProductData(
        catId: widget.catId, subCatId: "2", medium: widget.above10th ? "Commerce" : "Marathi"));
    futureForTab2Subcat4 = productController.getProductByMedium(new ProductData(
        catId: widget.catId, subCatId: "4", medium: widget.above10th ? "Commerce" : "Marathi"));

    futureForTab3Subcat1 = productController.getProductByMedium(new ProductData(
        catId: widget.catId, subCatId: "13", medium: widget.above10th ? "Arts" : "Hindi"));
    futureForTab3Subcat2 = productController.getProductByMedium(new ProductData(
        catId: widget.catId, subCatId: "1", medium: widget.above10th ? "Arts" : "Hindi"));
    futureForTab3Subcat3 = productController.getProductByMedium(new ProductData(
        catId: widget.catId, subCatId: "2", medium: widget.above10th ? "Arts" : "Hindi"));
    futureForTab3Subcat4 = productController.getProductByMedium(new ProductData(
        catId: widget.catId, subCatId: "4", medium: widget.above10th ? "Arts" : "Hindi"));

    _tabController = new TabController(length: 3, vsync: this);
    getFetchedStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: search == false
          ? buildAppBarWithSearch(context, loginResponse, () {
              setState(() {
                search = true;
              });
            })
          : null,
      drawer: CustomDrawer(loginResponse, cartData),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              search == true
                  ? Column(
                      children: [
                        Container(
                          height: 15,
                          decoration: BoxDecoration(color: kPrimaryColor),
                        ),
                        Stack(
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
                        ),
                      ],
                    )
                  : Container(
                      height: 0.0,
                      width: 0.0,
                    ),
              buildListingPoster(context, categoryBannerMap[widget.catId],widget.catId),
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
                  tabs: !widget.above10th
                      ? [
                          Tab(text: 'English Medium'),
                          Tab(text: 'Marathi Medium'),
                          Tab(text: 'Hindi Medium'),
                        ]
                      : [
                          Tab(text: 'Science'),
                          Tab(text: 'Commerce'),
                          Tab(text: 'Arts'),
                        ],
                  controller: _tabController,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              fetched
                  ? Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ListView(
                            children: [
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForTab1Subcat1, "Combos", widget.catId, "13"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForTab1Subcat2, "TextBook", widget.catId, "1"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForTab1Subcat3, "Digest", widget.catId, "2"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForTab1Subcat4, "Helping Hands", widget.catId, "4"),
                              SizedBox(height: 14.h)
                            ],
                          ),
                          ListView(
                            children: [
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForTab2Subcat1, "Combos", widget.catId, "13"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForTab2Subcat2, "TextBook", widget.catId, "1"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForTab2Subcat3, "Digest", widget.catId, "2"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForTab2Subcat4, "Helping Hands", widget.catId, "4"),
                              SizedBox(height: 14.h)
                            ],
                          ),
                          ListView(
                            children: [
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForTab3Subcat1, "Combos", widget.catId, "13"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForTab3Subcat2, "TextBook", widget.catId, "1"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForTab3Subcat3, "Digest", widget.catId, "2"),
                              subcategoryBuilder(loginResponse, cartData, context, size,
                                  futureForTab3Subcat4, "Helping Hands", widget.catId, "4"),
                              SizedBox(height: 14.h)
                            ],
                          ),
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

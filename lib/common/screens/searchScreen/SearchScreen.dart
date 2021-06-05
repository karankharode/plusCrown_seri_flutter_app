import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/404builder.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/data/product_list.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;
  final String keyword;
  const SearchScreen(this.loginResponse, this.cartData, this.keyword);

  @override
  _SearchScreenState createState() => _SearchScreenState(loginResponse, cartData);
}

class _SearchScreenState extends State<SearchScreen> {
  final LoginResponse loginResponse;
  final CartData cartData;
  bool search = false;
  _SearchScreenState(this.loginResponse, this.cartData);

  String searchKeyWord;
  Future futureForSearch;
  TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    searchKeyWord = widget.keyword;
    _searchController = TextEditingController(text: widget.keyword);
    futureForSearch = ProductController().getProductByKeyword(widget.keyword);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 56, //size.height * 0.13,
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: 10,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.5,
                ),
                height: size.height * 0.044,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kPrimaryColor, width: 1),
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        controller: _searchController,
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          searchKeyWord = _searchController.text;
                          futureForSearch = ProductController().getProductByKeyword(searchKeyWord);
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 11),
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
                      onTap: () => _searchController.clear(),
                      child: Image.asset(
                        'assets/images/cross_purple.png',
                        width: size.width * 0.06,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(2.5.w, 0.w, 2.5.w, 0),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                      height: 2.5.w,
                    ),
                    Text(
                      "Showing Results for - " + searchKeyWord ?? " ",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'GothamMedium',
                      ),
                    ),
                    FutureBuilder(
                        future: futureForSearch,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                            case ConnectionState.active:
                              return bookLoader();
                              break;
                            case ConnectionState.done:
                              if (snapshot.hasData) {
                                List<ProductData> prolist = snapshot.data;
                                if (prolist.isNotEmpty) {
                                  return Container(
                                      // height: (prolist.length / 2) * ((size.width / 2.8) * 2),
                                      child: GridView.count(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 2.9,
                                    mainAxisSpacing: 5.0,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                    physics: NeverScrollableScrollPhysics(),
                                    children: [...getProducts(prolist, loginResponse, cartData)],
                                  ));
                                } else {
                                  return notFoundBuilder(570.0);
                                }
                              } else {
                                return notFoundBuilder(570.0);
                              }
                              break;
                            default:
                              return bookLoader();
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getProducts(proListnew, loginResponse, cartData) {
    List<Widget> products = [];
    for (ProductData product in proListnew) {
      // products.add(Container(height: 40, color: Colors.blue));
      products.add(ProductList(product, loginResponse, cartData));
    }
    return products;
  }
}

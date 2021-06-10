import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/buildAppBarWithSearch.dart';
import 'package:seri_flutter_app/common/widgets/appBars/searchBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/listing-pages/screens/combosCard.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/homescreen/data/product_list.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';

class ShowView extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;
  final String title;
  final String catId;
  final String subcatId;
  final Future future;

  const ShowView(
      {this.title, this.cartData, this.loginResponse, this.catId, this.subcatId, this.future});

  @override
  _ShowViewState createState() => _ShowViewState(loginResponse: loginResponse, cartData: cartData);
}

class _ShowViewState extends State<ShowView> {
  final LoginResponse loginResponse;
  final CartData cartData;
  bool search = false;
  Future futureForShowAll;

  searchAction() {
    setState(() {
      search = true;
    });
  }

  _ShowViewState({this.loginResponse, this.cartData});

  @override
  void initState() {
    super.initState();
    if (widget.future == null) {
      futureForShowAll = ProductController().getProductBySubCategory(
          ProductData(catId: widget.catId.toString(), subCatId: widget.subcatId.toString()));
    } else {
      futureForShowAll = widget.future;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: search == false
          ? buildAppBarWithSearch(context, loginResponse, searchAction)
          // ? buildAppBarWithSearch(context, loginResponse,searchAction)
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
                    widget.title,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'GothamMedium',
                    ),
                  ),
                  FutureBuilder(
                      future: futureForShowAll,
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
                              return Container(
                                  // height: (prolist.length / 2) * ((size.width / 2.8) * 2),
                                  child: GridView.count(
                                crossAxisCount:
                                    (widget.title.split('-').first.toString() == "Combos") ? 1 : 2,
                                childAspectRatio:
                                    (widget.title.split('-').first.toString() == "Combos")
                                        ? 0.89
                                        : 2 / 2.9,
                                mainAxisSpacing: 5.0,
                                shrinkWrap: true,
                                padding: (widget.title.split('-').first.toString() == "Combos")
                                    ? EdgeInsets.fromLTRB(15, 0, 15, 15)
                                    : EdgeInsets.fromLTRB(0, 0, 0, 15),
                                physics: NeverScrollableScrollPhysics(),
                                children: (widget.title.split('-').first.toString() == "Combos")
                                    ? [...getCombos(context, 0, prolist, loginResponse, cartData)]
                                    : [...getProducts(prolist, loginResponse, cartData)],
                              ));
                            } else {
                              return Container();
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
    );
  }
}

List<Widget> getProducts(proListnew, loginResponse, cartData) {
  List<Widget> products = [];
  for (ProductData product in proListnew) {
    // products.add(Container(height: 40, color: Colors.blue));
    products.add(ProductList(product, loginResponse, cartData));
  }
  return products;
}

List<Widget> getCombos(context, index, proListnew, loginResponse, cartData) {
  List<Widget> products = [];
  for (ProductData product in proListnew) {
    // products.add(Container(height: 40, color: Colors.blue));
    products.add(comboCard(
        index: index, productData: product, loginResponse: loginResponse, cartData: cartData));
  }
  return products;
}

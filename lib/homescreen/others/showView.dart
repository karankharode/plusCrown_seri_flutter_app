import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/buildAppBarWithSearch.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
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

  const ShowView({this.title, this.cartData, this.loginResponse, this.catId, this.subcatId});

  @override
  _ShowViewState createState() => _ShowViewState(loginResponse: loginResponse, cartData: cartData);
}

class _ShowViewState extends State<ShowView> {
  final LoginResponse loginResponse;
  final CartData cartData;
  bool search = false;

  searchAction() {
    setState(() {
      search = true;
    });
  }

  _ShowViewState({this.loginResponse, this.cartData});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: search == false
          ? buildAppBarWithSearch(context, loginResponse, null)
          // ? buildAppBarWithSearch(context, loginResponse,searchAction)
          : null,
      drawer: CustomDrawer(loginResponse, cartData),
      body: Padding(
        padding: EdgeInsets.fromLTRB(2.5.w, 0.w, 2.5.w, 0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
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
                      future: ProductController().getProductBySubCategory(ProductData(
                          catId: widget.catId.toString(), subCatId: widget.subcatId.toString())),
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
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 2.9,
                                mainAxisSpacing: 5.0,
                                shrinkWrap: true,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                physics: NeverScrollableScrollPhysics(),
                                children: [...getProducts(prolist, loginResponse, cartData)],
                                // itemBuilder: (BuildContext context, int index) {
                                //   return Padding(
                                //     padding: const EdgeInsets.fromLTRB(20, 6, 20, 4),
                                //     child:
                                //         ProductList(prolist[index], loginResponse, cartData),
                                //   );
                                // }
                              )
                                  // child: ListView.builder(
                                  //   physics: NeverScrollableScrollPhysics(),
                                  //   padding: EdgeInsets.only(bottom: 50),
                                  //   itemCount: prolist.length,
                                  //   itemBuilder: (BuildContext context, int index) {
                                  //     return Padding(
                                  //       padding: const EdgeInsets.fromLTRB(20, 6, 20, 4),
                                  //       child: ProductList(prolist[index], loginResponse, cartData),
                                  //     );
                                  //   },
                                  // ),
                                  );
                            } else {
                              return Container();
                            }
                            break;
                          default:
                            return bookLoader();
                        }
                      }),

                  // Wrap(
                  //   children: [...getProducts(context, loginResponse, cartData)],
                  // )
                ],
              ),
            ),
          ],
        ),
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

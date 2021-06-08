import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/networkImageBuilder.dart';
import 'package:seri_flutter_app/empty-wishlist/controller/wishListController.dart';
import 'package:seri_flutter_app/empty-wishlist/emptyWishListPage.dart';
import 'package:seri_flutter_app/empty-wishlist/models/AddtoWishlistData.dart';
import 'package:seri_flutter_app/empty-wishlist/models/WishListData.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

// ignore_for_file: non_constant_identifier_names
class WishList extends StatefulWidget {
  final LoginResponse loginResponse;

  const WishList({this.loginResponse});
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  double convertToDigit(textInput) {
    return double.parse(textInput);
  }

  showDeleteConfirmationDialog(productid, bool all) {
    Alert(
      context: context,
      title: all
          ? "Do you want to Delete all items from WishList ?"
          : "Do you want to Delete an item from WishList ?",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if (all)
              print("All");
            // deleteAllCartItems();
            else
              deleteWishListItem(productid);

            Navigator.pop(context);
          },
          width: 120,
          color: Color.fromARGB(255, 71, 54, 111),
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          width: 120,
          color: Color.fromARGB(255, 71, 54, 111),
        )
      ],
    ).show();
  }

  deleteWishListItem(productid) async {
    bool deleted = await WishlistController().removeFromWishlist(
        AddToWishlistData(customerId: widget.loginResponse.id, productId: productid));
    if (deleted) {
      setState(() {});
      Flushbar(
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        message: "Deleted Successfully",
        icon: Icon(
          Icons.info_outline,
          size: 20,
          color: Colors.lightBlue[800],
        ),
        duration: Duration(seconds: 2),
      )..show(context);

      // setState(() {});
    } else {
      Flushbar(
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        message: "Error deleting from Cart",
        icon: Icon(
          Icons.info_outline,
          size: 20,
          color: Colors.lightBlue[800],
        ),
        duration: Duration(seconds: 2),
      )..show(context);
    }
  }

  bool productsLoaded = false;

  var wishList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: WishlistController()
            .getWishlistDetails(GetWishlistData(customerId: widget.loginResponse.id)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            WishlistData wishListData = snapshot.data;
            List<WishlistProduct> wishListProductsList = wishListData.wishlistProducts;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return bookLoader();
                break;
              case ConnectionState.done:
                if (wishListProductsList.length > 0) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: wishListData.wishlistProducts.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleProdWL(
                            showDeleteConfirmationDialog: showDeleteConfirmationDialog,
                            productId: wishListProductsList[index].productId,
                            prodName: wishListProductsList[index].productName,
                            loginResponse: widget.loginResponse,
                            image: wishListProductsList[index].product_image,
                            percentOff: wishListProductsList[index].product_discountoff,
                            actual_price: wishListProductsList[index].product_mrp,
                            final_price: wishListData.wishlistProducts[index].productPrice,
                            available: wishListProductsList[index].product_isavailable);
                      });
                } else {
                  return EmptyWishListPage(
                    widget.loginResponse,
                  );
                }
                break;
              default:
                return bookLoader();
            }
          } else {
            return bookLoader();
          }
        });

    // wishList.isEmpty
    //   ? Center(
    //   child: Text(
    //     "Your Wish List is empty",
    //     style: TextStyle(fontSize: 20),
    //   ))
    //   :
  }
}

class SingleProdWL extends StatefulWidget {
  final int productId;
  final String prodName;
  final image;
  final String percentOff;
  final String actual_price;
  final String final_price;
  final available;
  final LoginResponse loginResponse;
  final Function showDeleteConfirmationDialog;

  SingleProdWL(
      {this.productId,
      this.prodName,
      this.image,
      this.percentOff,
      this.actual_price,
      this.final_price,
      this.available,
      this.loginResponse,
      this.showDeleteConfirmationDialog});

  @override
  _SingleProdWLState createState() => _SingleProdWLState();
}

class _SingleProdWLState extends State<SingleProdWL> {
  bool checkedValue = false;
  addProductToCart(AddToCartData addToCartData) async {
    bool response = await CartController().addToCart(addToCartData);
    if (response) {
      Flushbar(
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        message: "Added Successfully",
        icon: Icon(
          Icons.info_outline,
          size: 20,
          color: Colors.lightBlue[800],
        ),
        duration: Duration(seconds: 2),
      )..show(context);
      setState(() {});
    } else {
      Flushbar(
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        message: "Error adding to Cart",
        icon: Icon(
          Icons.info_outline,
          size: 20,
          color: Colors.lightBlue[800],
        ),
        duration: Duration(seconds: 2),
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 6, 4, 6),
        child: Container(
          // height: 160,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 2.0,
                    color: Color(0xbb999999),
                    spreadRadius: 1.6,
                    offset: Offset(1, 1))
              ],
              border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Stack(
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              height: 130,
                              width: MediaQuery.of(context).size.width / 3.5,
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black),
                              ),
                              child: coverPageimageBuilder(widget.image)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  width: MediaQuery.of(context).size.width / 2.2,
                                  //  height: 30,
                                  child: Text(
                                    widget.prodName,
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        fontSize: MediaQuery.of(context).size.width / 25,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 71, 54, 111)),
                                  ),
                                ),

                                // GestureDetector(
                                //   onTap: (){
                                //
                                //   },
                                //   child: Align(
                                //     alignment: Alignment.topRight,
                                //     child: Icon(Icons.more_vert, color: Color.fromARGB(
                                //         255, 71, 54, 111) ,),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(height: 8),
                            widget.available == true
                                ? Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          //    crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          //   mainAxisSize: MainAxisSize.min,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                  text: "\u20B9 ",
                                                  style: TextStyle(
                                                      fontFamily: 'GothamMedium',
                                                      fontSize:
                                                          MediaQuery.of(context).size.width / 27,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Color.fromARGB(255, 71, 54, 111)),
                                                  children: [
                                                    TextSpan(
                                                      text: widget.final_price,
                                                      style: TextStyle(
                                                          fontFamily: 'GothamMedium',
                                                          fontSize:
                                                              MediaQuery.of(context).size.width /
                                                                  27,
                                                          color: Color.fromARGB(255, 71, 54, 111)),
                                                    )
                                                  ]),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: "\u20B9 ",
                                                  style: TextStyle(
                                                      fontFamily: 'GothamMedium',
                                                      fontSize:
                                                          MediaQuery.of(context).size.width / 27,
                                                      decoration: TextDecoration.lineThrough,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Color.fromARGB(255, 71, 54, 111)),
                                                  children: [
                                                    TextSpan(
                                                      text: widget.actual_price,
                                                      style: TextStyle(
                                                          fontFamily: 'GothamMedium',
                                                          decoration: TextDecoration.lineThrough,
                                                          fontSize:
                                                              MediaQuery.of(context).size.width /
                                                                  27,
                                                          color: Color.fromARGB(255, 71, 54, 111)),
                                                    )
                                                  ]),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: widget.percentOff,
                                                  style: TextStyle(
                                                      fontFamily: 'GothamMedium',
                                                      fontSize:
                                                          MediaQuery.of(context).size.width / 27,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.green),
                                                  children: [
                                                    TextSpan(
                                                      text: "% Off",
                                                      style: TextStyle(
                                                          fontFamily: 'GothamMedium',
                                                          fontSize:
                                                              MediaQuery.of(context).size.width /
                                                                  27,
                                                          color: Colors.green),
                                                    )
                                                  ]),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Price inclusive of all taxes",
                                          style: TextStyle(
                                              fontFamily: 'GothamMedium',
                                              fontSize: MediaQuery.of(context).size.width / 29,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    // alignment: Alignment.bottomRight,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        //  mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 50,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context).size.width / 23,
                                            decoration: BoxDecoration(
                                                color: Colors.red[200],
                                                border: Border.all(color: Colors.grey[200]),
                                                borderRadius: BorderRadius.all(Radius.circular(8))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(
                                                "  Unavailable  ",
                                                style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontSize:
                                                        MediaQuery.of(context).size.width / 23,
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context).size.height / 25,
                                      // alignment: Alignment.bottomRight,
                                      child: ElevatedButton(
                                        child: Text("Add to cart",
                                            style: TextStyle(
                                                fontFamily: 'GothamMedium',
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context).size.width / 25)),
                                        onPressed: () {
                                          AddToCartData add = new AddToCartData(
                                              customerId: widget.loginResponse.id,
                                              productId: widget.productId);
                                          addProductToCart(add);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(255, 71, 54, 111),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 1,
                right: 1,
                child: PopupMenuButton(
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext bc) => [
                    // PopupMenuItem(
                    //     child: Text(
                    //       "Edit",
                    //       style: TextStyle(
                    //           fontFamily: 'GothamMedium',
                    //           fontWeight: FontWeight.w600,
                    //           color: Color.fromARGB(255, 71, 54, 111)),
                    //     ),
                    //     value: "1"),
                    PopupMenuItem(
                        child: Text(
                          "Delete",
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 71, 54, 111)),
                        ),
                        value: "2"),
                  ],
                  onSelected: (value) {
                    if (value == "2") {
                      widget.showDeleteConfirmationDialog(widget.productId, false);
                    }
                  },
                  // onSelected: (route) {
                  //   Navigator.pushNamed(context, route);
                  // },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

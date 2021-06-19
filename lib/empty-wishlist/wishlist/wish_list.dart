import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/currentlyAvailable.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/networkImageBuilder.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/showFlushBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/showLoadingDialog.dart';
import 'package:seri_flutter_app/empty-wishlist/controller/wishListController.dart';
import 'package:seri_flutter_app/empty-wishlist/emptyWishListPage.dart';
import 'package:seri_flutter_app/empty-wishlist/models/AddtoWishlistData.dart';
import 'package:seri_flutter_app/empty-wishlist/models/WishListData.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/others/page_one.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

// ignore_for_file: non_constant_identifier_names
class WishList extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const WishList({this.loginResponse, this.cartData});
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
      style: AlertStyle(overlayColor: Colors.black.withOpacity(0.4)),
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if (all)
              deleteAllWishListItem();
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
      showCustomFlushBar(context, "Deleted Successfully", 2);
    } else {
      showCustomFlushBar(context, "Error deleting from WishList", 2);
    }
  }

  deleteAllWishListItem() async {
    bool deleted = await WishlistController()
        .removeAllFromWishlist(GetWishlistData(customerId: widget.loginResponse.id));
    if (deleted) {
      setState(() {});
      showCustomFlushBar(context, "Deleted All Products Successfully", 2);
    } else {
      showCustomFlushBar(context, "Error deleting from WishList", 2);
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
                  return Column(
                    children: [
                      ListView.builder(
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
                                cartData: widget.cartData,
                                image: wishListProductsList[index].product_image,
                                percentOff: wishListProductsList[index].product_discountoff,
                                actual_price: wishListProductsList[index].product_mrp,
                                final_price: wishListData.wishlistProducts[index].productPrice,
                                available: wishListProductsList[index].product_isavailable);
                          }),
                      Padding(
                        padding: const EdgeInsets.only(right: 7.0, top: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 25,
                          // alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            child: Text("Remove All",
                                style: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    color: Colors.red,
                                    fontSize: MediaQuery.of(context).size.width / 25)),
                            onPressed: () {
                              showDeleteConfirmationDialog(null, true);
                            },
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red[100].withOpacity(0.9)),
                          ),
                        ),
                        // child: GestureDetector(
                        //   onTap: () {
                        //     // showDeleteConfirmationDialog(null, true);
                        //   },
                        //   child: Container(
                        //     decoration: BoxDecoration(border:),
                        //     child: Text(
                        //       "Remove all",
                        //       style: TextStyle(
                        //           fontFamily: 'GothamMedium', fontSize: 16, color: Colors.red),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ],
                  );
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
  final CartData cartData;
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
      this.showDeleteConfirmationDialog,
      this.cartData});

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
      child: GestureDetector(
        onTap: () {
          showLoadingDialog(context);
          Future futureForProductDetailsPage = ProductController().getProductById(widget.productId);
          futureForProductDetailsPage.then((value) {
            Navigator.pop(context);
            Navigator.push(
                context, commonRouter(PageOne(value, widget.loginResponse, widget.cartData)));
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 6, 4, 6),
          child: Stack(
            children: [
              Container(
                // height: 160,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2.0,
                          color: Color(0xaa999999),
                          spreadRadius: 1.4,
                          offset: Offset(1, 1))
                    ],
                    border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: 140,
                            width: MediaQuery.of(context).size.width / 3.6,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black),
                            ),
                            child: coverPageimageBuilder(widget.image)),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              SizedBox(height: 15),
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
                                                            color:
                                                                Color.fromARGB(255, 71, 54, 111)),
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
                                                            color:
                                                                Color.fromARGB(255, 71, 54, 111)),
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
                                                fontSize: MediaQuery.of(context).size.width / 34,
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
                                        SizedBox(height: 6),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          //  mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width / 50,
                                            ),
                                            currentlyUnavailableBuilder(),
                                          ],
                                        ),
                                      ],
                                    ),
                              SizedBox(
                                height: 15,
                              ),
                               ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: 
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon:Icon(Icons.highlight_remove_rounded,color: Colors.grey,),onPressed:()=>widget.showDeleteConfirmationDialog(widget.productId, false)),
                  // PopupMenuButton(
                  //   padding: EdgeInsets.zero,
                  //   itemBuilder: (BuildContext bc) => [
                  //     // PopupMenuItem(
                  //     //     child: Text(
                  //     //       "Edit",
                  //     //       style: TextStyle(
                  //     //           fontFamily: 'GothamMedium',
                  //     //           fontWeight: FontWeight.w600,
                  //     //           color: Color.fromARGB(255, 71, 54, 111)),
                  //     //     ),
                  //     //     value: "1"),
                  //     PopupMenuItem(
                  //         child: Text(
                  //           "Delete",
                  //           style: TextStyle(
                  //               fontFamily: 'GothamMedium',
                  //               fontWeight: FontWeight.w600,
                  //               color: Color.fromARGB(255, 71, 54, 111)),
                  //         ),
                  //         value: "2"),
                  //   ],
                  //   onSelected: (value) {
                  //     if (value == "2") {
                  //       widget.showDeleteConfirmationDialog(widget.productId, false);
                  //     }
                  //   },
                  //   // onSelected: (route) {
                  //   //   Navigator.pushNamed(context, route);
                  //   // },
                  // ),
               
                ),
                widget.available == true
                                  ? Positioned(right: 9,bottom: 9,
                                                                      child: Container(
                                                                        height: MediaQuery.of(context).size.height / 25,
                                                                        // alignment: Alignment.bottomRight,
                                                                        child: ElevatedButton(
                                                                          child: Text("Add to cart",
                                                                              style: TextStyle(
                                                                                  fontFamily: 'GothamMedium',
                                                                                  color: Colors.white,
                                                                                  fontSize:
                                                                                      MediaQuery.of(context).size.width / 25)),
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
                                  )
                                  : Container()
                           
            ],
          ),
        ),
      ),
    );
  }
}

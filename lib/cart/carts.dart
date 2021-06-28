import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:seri_flutter_app/cart/cart_product.dart';
import 'package:seri_flutter_app/cart/models/DeleteFromCartData.dart';
import 'package:seri_flutter_app/checkOut/screens/CheckOutPage.dart';
import 'package:seri_flutter_app/checkOut/screens/giftPage.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/common/widgets/appBars/searchBar.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/homescreen/screens/home_screen.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'controller/CartController.dart';
import 'models/AddToCartData.dart';
import 'models/CartData.dart';

class Cart extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Cart(this.loginResponse, this.cartData);

  @override
  _CartState createState() => _CartState(loginResponse: loginResponse, cartData: cartData);
}

class _CartState extends State<Cart> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _CartState({this.loginResponse, this.cartData});

  bool checkValue = false;
  double totalAmt = 0.00;
  double cardTotal;
  double cardSavings;
  double gift;
  int giftCount = 0;
  double couponSavings;
  bool containsGift = false;

  Future futureForCart;

  var cartController = CartController();

  @override
  void initState() {
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    getGlobalCartData();
    super.initState();
  }

  getGlobalCartData() async {
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    futureForCart.then((value) {
      setState(() {
        globalCartData = value;
      });
    });
  }

  giftCheck(bool value) {
    if (value) {
      setState(() {
        giftCount = ++giftCount;
        containsGift = true;
      });
    } else {
      giftCount = --giftCount;
      containsGift = giftCount != 0;
    }
  }

  showDeleteConfirmationDialog(productid, bool all) {
    Alert(
      context: context,
      title: all
          ? "Do you want to Delete all items from Cart ?"
          : "Do you want to Delete an item from Cart ?",
      style: AlertStyle(overlayColor: Colors.black.withOpacity(0.4)),
      buttons: [
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
        ),
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if (all)
              deleteAllCartItems();
            else
              deleteCartItem(productid);

            Navigator.pop(context);
          },
          width: 120,
          color: Color.fromARGB(255, 71, 54, 111),
        ),
      ],
    ).show();
  }

  deleteCartItem(productid) async {
    bool deleted = await CartController()
        .removeFromCart(DeleteFromCartData(customerId: loginResponse.id, productId: productid));
    if (deleted) {
      getGlobalCartData();
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

  deleteAllCartItems() {
    globalCartData.cartProducts.forEach((element) {
      deleteCartItem(element.productId);
    });
    // Navigator.pop(context);
  }

  bool search = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return globalCartData.cartProducts.length != 0
        ? Scaffold(
            appBar: search == false
                ? buildTextAppBar(context, "Cart", loginResponse, false, false, () {
                    setState(() {
                      search = true;
                    });
                  })
                : null,
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    search == true
                        ? SearchBar(context, size, () {
                            setState(() {
                              search = false;
                            });
                          }, loginResponse, cartData)
                        : Container(),
                    FutureBuilder(
                        future: futureForCart,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            CartData cartDataFromSnapshot = snapshot.data;
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.active:
                              case ConnectionState.waiting:
                                return bookLoader();
                                break;
                              case ConnectionState.done:
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "  " +
                                                  cartDataFromSnapshot.cartProducts.length
                                                      .toString() +
                                                  " item(s) in the Cart",
                                              style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  fontSize: MediaQuery.of(context).size.width / 25,
                                                  color: Color.fromARGB(255, 71, 54, 111)),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 7.0,
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDeleteConfirmationDialog(null, true);
                                                },
                                                child: Text(
                                                  "Clear Cart",
                                                  style: TextStyle(
                                                      fontFamily: 'GothamMedium',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: MediaQuery.of(context).size.width/80,
                                            // ),
                                            // Text(
                                            //   "Total amount  \u20B9 " +
                                            //       cartDataFromSnapshot.cartPrice +
                                            //       " ",
                                            //   style: TextStyle(
                                            //       fontFamily: 'GothamMedium',
                                            //       fontSize: MediaQuery.of(context).size.width / 25,
                                            //       color: Color.fromARGB(255, 71, 54, 111)),
                                            // )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CartList(loginResponse, cartDataFromSnapshot,
                                          showDeleteConfirmationDialog, giftCheck),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(width: 2),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //     right: 7.0,
                                          //   ),
                                          //   child: GestureDetector(
                                          //     onTap: () {
                                          //       showDeleteConfirmationDialog(null, true);
                                          //     },
                                          //     child: Text(
                                          //       "Remove all",
                                          //       style: TextStyle(
                                          //           fontFamily: 'GothamMedium',
                                          //           fontSize: 12,
                                          //           color: Colors.red),
                                          //     ),
                                          //   ),
                                          // ),

                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(
                                                      Color.fromARGB(255, 71, 54, 111))),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    commonRouter(HomePage(
                                                      loginResponse: loginResponse,
                                                      cartData: cartDataFromSnapshot,
                                                    )));
                                              },
                                              child: Text(
                                                "Continue Shopping",
                                                style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),

                                          // SizedBox(width: MediaQuery.of(context).size.width ,),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                );
                              default:
                                return bookLoader();
                            }
                          } else {
                            return bookLoader();
                          }
                        }),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              height: 56,
              child: ElevatedButton(
                child: Text("Proceed to Checkout",
                    style: TextStyle(
                        fontFamily: 'GothamMedium',
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 24)),
                onPressed: () {
                  // if (containsGift) {
                  //   Navigator.push(
                  //       context,
                  //       commonRouter(GiftPage(
                  //         count: giftCount,
                  //         loginResponse: loginResponse,
                  //         cartData: cartData,
                  //         gift_msg: "",
                  //         gift_from: loginResponse.id.toString(),
                  //       )));
                  // } else {
                  Navigator.push(
                      context,
                      commonRouter(CheckOutPage(
                        loginResponse: loginResponse,
                        cartData: cartData,
                        gift_msg: "gift message will be inserted here",
                        gift_from: loginResponse.id.toString(),
                      )));
                  // }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 71, 54, 111),
                ),
              ),
            ),
          )
        : EmptyCartPage(loginResponse, cartData);
  }
}

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:seri_flutter_app/cart/cart_product.dart';
import 'package:seri_flutter_app/cart/models/DeleteFromCartData.dart';
import 'package:seri_flutter_app/checkOut/screens/CheckOutPage.dart';
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
    setState(() {
      containsGift = value;
    });
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
                                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 10),
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
                                               padding: const EdgeInsets.all(8.0),
                                               child: ElevatedButton(
                                                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 71, 54, 111))),
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
                                      if (containsGift == true)
                                        Container(
                                          // height: 250,
                                          width: MediaQuery.of(context).size.width - 15,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Color.fromARGB(255, 71, 54, 111)),
                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("This Order Contains Gift",
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                          fontFamily: 'GothamMedium',
                                                          color: Colors.green,
                                                          fontSize:
                                                              MediaQuery.of(context).size.width /
                                                                  22)),
                                                  SizedBox(height: 3),
                                                  Text("Add Gift Message",
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                          fontFamily: 'GothamMedium',
                                                          color: Color.fromARGB(255, 71, 54, 111),
                                                          fontSize:
                                                              MediaQuery.of(context).size.width /
                                                                  24)),
                                                  Container(
                                                    height: 120,
                                                    width: MediaQuery.of(context).size.width * 2,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Color.fromARGB(255, 71, 54, 111)),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        TextFormField(
                                                            textAlign: TextAlign.start,
                                                            maxLines: 3,
                                                            //   controller: couponTextEditingController,
                                                            style: TextStyle(
                                                                fontFamily: 'GothamMedium',
                                                                color: Color.fromARGB(
                                                                    255, 71, 54, 111),
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: MediaQuery.of(context)
                                                                        .size
                                                                        .width /
                                                                    22),
                                                            decoration: InputDecoration(
                                                              border: InputBorder.none,
                                                              hintText: 'Type Your Gift Message',
                                                              hintStyle: TextStyle(
                                                                fontWeight: FontWeight.w300,
                                                                fontFamily: 'GothamMedium',
                                                                color: Color.fromARGB(
                                                                    255, 71, 54, 111),
                                                              ),
                                                              labelStyle: TextStyle(
                                                                  fontSize: MediaQuery.of(context)
                                                                          .size
                                                                          .width /
                                                                      24),
                                                            )),
                                                        Divider(
                                                          color: Color.fromARGB(255, 71, 54, 111),
                                                          height: 1,
                                                          thickness: 1,
                                                        ),
                                                        Container(
                                                          // height:  MediaQuery.of(context).size.height/ 25,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.center,
                                                            children: [
                                                              Text("From:  ",
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                      fontFamily: 'GothamMedium',
                                                                      color: Color.fromARGB(
                                                                          255, 71, 54, 111),
                                                                      fontSize:
                                                                          MediaQuery.of(context)
                                                                                  .size
                                                                                  .width /
                                                                              24)),
                                                              // SizedBox(
                                                              //   width: 2,
                                                              // ),
                                                              // Padding(
                                                              //   padding:
                                                              //   EdgeInsets.only(top: MediaQuery.of(context).size.height / 55),
                                                              //   child:
                                                              Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.02,
                                                                  ),
                                                                  Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        30,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width -
                                                                        97,
                                                                    child: TextFormField(
                                                                      maxLines: 1,
                                                                      textAlign: TextAlign.left,
                                                                      //   controller: couponTextEditingController,
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontFamily:
                                                                              'GothamMedium',
                                                                          color: Color.fromARGB(
                                                                              255, 71, 54, 111),
                                                                          fontSize:
                                                                              MediaQuery.of(context)
                                                                                      .size
                                                                                      .width /
                                                                                  22),
                                                                      decoration: InputDecoration(
                                                                        border: InputBorder.none,
                                                                        hintText: '',
                                                                        hintStyle: TextStyle(
                                                                          fontFamily:
                                                                              'GothamMedium',
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: Color.fromARGB(
                                                                              255, 71, 54, 111),
                                                                        ),
                                                                        labelStyle: TextStyle(
                                                                            fontSize: MediaQuery.of(
                                                                                        context)
                                                                                    .size
                                                                                    .width /
                                                                                22),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              //    ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text("Add-ons",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: 'GothamMedium',
                                                          color: Color.fromARGB(255, 71, 54, 111),
                                                          fontSize:
                                                              MediaQuery.of(context).size.width /
                                                                  30)),
                                                  SizedBox(height: 8),
                                                  Row(
                                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 2.0),
                                                        child: SizedBox(
                                                          height:
                                                              MediaQuery.of(context).size.width /
                                                                  30,
                                                          width: MediaQuery.of(context).size.width /
                                                              30,
                                                          child: Transform.scale(
                                                            scale: 0.8,
                                                            child: Checkbox(
                                                              activeColor:
                                                                  Color.fromARGB(255, 71, 54, 111),
                                                              value: checkValue,
                                                              onChanged: (newValue) {
                                                                setState(() {
                                                                  checkValue = newValue;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                            text: "Add Gift Bag/Box",
                                                            style: TextStyle(
                                                              fontFamily: 'GothamMedium',
                                                              fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  29,
                                                              color:
                                                                  Color.fromARGB(255, 71, 54, 111),
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    "(Additional charges - RS 50)",
                                                                style: TextStyle(
                                                                    fontFamily: 'GothamMedium',
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        29,
                                                                    color: Colors.red),
                                                              )
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 24.0),
                                                        child: Icon(Icons.wallet_giftcard,
                                                            color: Colors.redAccent,
                                                            size:
                                                                MediaQuery.of(context).size.height /
                                                                    18),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 8.0),
                                                        child: ElevatedButton(
                                                          child: Text("See Details",
                                                              style: TextStyle(
                                                                  fontFamily: 'GothamMedium',
                                                                  color: Colors.red,
                                                                  fontSize: MediaQuery.of(context)
                                                                          .size
                                                                          .width /
                                                                      25)),
                                                          onPressed: () {},
                                                          style: ElevatedButton.styleFrom(
                                                            primary: Colors.white,
                                                            elevation: 1,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(10),
                                                                side: BorderSide(
                                                                    color: Colors.black54,
                                                                    width: 0.5)),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ]),
                                          ),
                                        ),
                                      SizedBox(
                                        height: 10,
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
                  Navigator.push(
                      context,
                      commonRouter(CheckOutPage(
                        loginResponse: loginResponse,
                        cartData: cartData,
                        
                      )));
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

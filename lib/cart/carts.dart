import 'package:badges/badges.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seri_flutter_app/cart/cart_product.dart';
import 'package:seri_flutter_app/cart/models/DeleteFromCartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';
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

  bool apply = false;
  bool checkValue = false;
  bool delivery = true;
  double totalAmt = 500.00;
  double cardTotal;
  double cardSavings;
  double gift;
  double couponSavings;
  bool containsGift = true;

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
    CartData fcardData = await cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    setState(() {
      globalCartData = fcardData;
    });
  }

  fetchGlobalCartData() async {
    CartData fcardData = await cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    setState(() {
      globalCartData = fcardData;
    });
  }

  deleteCartItem(productid) async {
    bool deleted = await CartController()
        .removeFromCart(DeleteFromCartData(customerId: loginResponse.id, productId: productid));
    if (deleted) {
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
      fetchGlobalCartData();
      setState(() {});
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
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         content: Container(
    //           color: Colors.white,
    //           child: Row(
    //             children: [CircularProgressIndicator(), Text(" Deleting")],
    //           ),
    //         ),
    //       );
    //     });
    globalCartData.cartProducts.forEach((element) {
      deleteCartItem(element.productId);
    });
    // Navigator.pop(context);
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController couponTextEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool search = false;
    return globalCartData.cartProducts.length != 0
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 71, 54, 111),
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/icons/leftarrowwhite.png',
                    width: MediaQuery.of(context).size.width * 0.07,
                  ),
                ),
              ),
              title: Text(
                "Cart",
                style: TextStyle(fontFamily: 'GothamMedium', fontSize: 16.sp),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          'assets/icons/search3.png',
                          width: MediaQuery.of(context).size.width * 0.07,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FutureBuilder(
                          future: CartController().getCartDetails(AddToCartData(
                            customerId: loginResponse.id,
                          )),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              CartData cartDataFromSnapshot = snapshot.data;
                              return GestureDetector(
                                onTap: () {
                                  // cartDataFromSnapshot.cartProducts.length == 0
                                  //     ? Navigator.of(context).push(MaterialPageRoute(
                                  //         builder: (BuildContext context) => EmptyCartPage(
                                  //               loginResponse,
                                  //               cartData,
                                  //             )))
                                  //     : Navigator.of(context).push(MaterialPageRoute(
                                  //         builder: (BuildContext context) => Cart(
                                  //               loginResponse,
                                  //               cartData,
                                  //             )));
                                },
                                child: Badge(
                                    position: BadgePosition.topEnd(top: -8, end: -10),
                                    badgeColor: Colors.white,
                                    badgeContent: Text(
                                      cartDataFromSnapshot.cartProducts.length.toString(),
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: MediaQuery.of(context).size.width / 35),
                                    ),
                                    child: Image.asset(
                                      'assets/icons/cart1.png',
                                      width: MediaQuery.of(context).size.width * 0.07,
                                    )),
                              );
                            } else {
                              return Container();
                            }
                          }),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 11.0, right: 11, top: 18, bottom: 18),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " " +
                                globalCartData.cartProducts.length.toString() +
                                " items in the Cart",
                            style: TextStyle(
                                fontFamily: 'GothamMedium',
                                fontSize: MediaQuery.of(context).size.width / 25,
                                color: Color.fromARGB(255, 71, 54, 111)),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width/80,
                          // ),
                          Row(
                            children: [
                              Text(
                                "Total amount Rs ",
                                style: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    fontSize: MediaQuery.of(context).size.width / 25,
                                    color: Color.fromARGB(255, 71, 54, 111)),
                              ),
                              Text(
                                globalCartData.cartPrice,
                                style: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    fontSize: MediaQuery.of(context).size.width / 25,
                                    color: Color.fromARGB(255, 71, 54, 111)),
                              ),
                            ],
                          )
                        ],
                      ),
                      FutureBuilder(
                          future: CartController().getCartDetails(AddToCartData(
                            customerId: loginResponse.id,
                          )),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data);
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return CircularProgressIndicator();
                                  break;
                                case ConnectionState.done:
                                  return Flexible(
                                      child:
                                          CartList(loginResponse, snapshot.data, deleteCartItem));
                                  break;
                                default:
                                  return CircularProgressIndicator();
                              }
                            } else {
                              return Container();
                            }
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(onTap: () {}, child: Icon(Icons.add)),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 7.0,
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "add more products",
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 71, 54, 111)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(width: MediaQuery.of(context).size.width ,),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 7.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                deleteAllCartItems();
                              },
                              child: Text(
                                "Remove all",
                                style: TextStyle(
                                    fontFamily: 'GothamMedium', fontSize: 12, color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      if (containsGift == true)
                        Container(
                          // height: 250,
                          width: MediaQuery.of(context).size.width - 15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
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
                                          fontSize: MediaQuery.of(context).size.width / 22)),
                                  SizedBox(height: 3),
                                  Text("Add Gift Message",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context).size.width / 24)),
                                  Container(
                                    height: 120,
                                    width: MediaQuery.of(context).size.width * 2,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
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
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                fontWeight: FontWeight.w500,
                                                fontSize: MediaQuery.of(context).size.width / 22),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Type Your Gift Message',
                                              hintStyle: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontFamily: 'GothamMedium',
                                                color: Color.fromARGB(255, 71, 54, 111),
                                              ),
                                              labelStyle: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width / 24),
                                            )),
                                        Divider(
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          height: 1,
                                          thickness: 1,
                                        ),
                                        Container(
                                          // height:  MediaQuery.of(context).size.height/ 25,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("From:  ",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'GothamMedium',
                                                      color: Color.fromARGB(255, 71, 54, 111),
                                                      fontSize:
                                                          MediaQuery.of(context).size.width / 24)),
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
                                                    height:
                                                        MediaQuery.of(context).size.height * 0.02,
                                                  ),
                                                  Container(
                                                    height: MediaQuery.of(context).size.height / 30,
                                                    width: MediaQuery.of(context).size.width - 97,
                                                    child: TextFormField(
                                                      maxLines: 1,
                                                      textAlign: TextAlign.left,
                                                      //   controller: couponTextEditingController,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontFamily: 'GothamMedium',
                                                          color: Color.fromARGB(255, 71, 54, 111),
                                                          fontSize:
                                                              MediaQuery.of(context).size.width /
                                                                  22),
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: '',
                                                        hintStyle: TextStyle(
                                                          fontFamily: 'GothamMedium',
                                                          fontWeight: FontWeight.w300,
                                                          color: Color.fromARGB(255, 71, 54, 111),
                                                        ),
                                                        labelStyle: TextStyle(
                                                            fontSize:
                                                                MediaQuery.of(context).size.width /
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
                                          fontSize: MediaQuery.of(context).size.width / 30)),
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
                                          height: MediaQuery.of(context).size.width / 30,
                                          width: MediaQuery.of(context).size.width / 30,
                                          child: Transform.scale(
                                            scale: 0.8,
                                            child: Checkbox(
                                              activeColor: Color.fromARGB(255, 71, 54, 111),
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
                                              fontSize: MediaQuery.of(context).size.width / 29,
                                              color: Color.fromARGB(255, 71, 54, 111),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: "(Additional charges - RS 50)",
                                                style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontSize:
                                                        MediaQuery.of(context).size.width / 29,
                                                    color: Colors.red),
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 24.0),
                                        child: Icon(Icons.wallet_giftcard,
                                            color: Colors.redAccent,
                                            size: MediaQuery.of(context).size.height / 18),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: ElevatedButton(
                                          child: Text("See Details",
                                              style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  color: Colors.red,
                                                  fontSize:
                                                      MediaQuery.of(context).size.width / 25)),
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                            elevation: 1,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                side:
                                                    BorderSide(color: Colors.black54, width: 0.5)),
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width / 1.78,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: couponTextEditingController,
                              style: TextStyle(
                                  fontFamily: 'GothamMedium', color: Colors.red, fontSize: 16),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type Coupon Code',
                                hintStyle:
                                    TextStyle(fontFamily: 'GothamMedium', color: Colors.grey),
                                labelStyle: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          if (apply == false)
                            Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width / 3.2,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 71, 54, 111),
                                border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      couponTextEditingController.text = "xyz";
                                      apply = true;
                                    });
                                  },
                                  child: Text("Apply",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color: Colors.white,
                                          fontSize: 16)),
                                ),
                              ),
                            ),
                          if (apply == true)
                            Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width / 3.2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      couponTextEditingController.text = " ";
                                    });
                                  },
                                  child: Text("Remove",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontSize: 16)),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Divider(
                        color: Color.fromARGB(255, 71, 54, 111),
                        height: 10,
                        thickness: 1,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Order Details",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontSize: MediaQuery.of(context).size.width / 22,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Card Total",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    color: Color.fromARGB(255, 71, 54, 111),
                                    fontSize: MediaQuery.of(context).size.width / 24,
                                  )),
                              Row(
                                children: [
                                  Text("Rs ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context).size.width / 24)),
                                  Text("5297",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context).size.width / 24)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Card Savings ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontSize: MediaQuery.of(context).size.width / 24)),
                              Row(
                                children: [
                                  Text("- Rs ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context).size.width / 24)),
                                  Text("1803",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context).size.width / 24)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          if (couponTextEditingController.text == "xyz")
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Coupon Savings ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'GothamMedium',
                                            color: Color.fromARGB(255, 71, 54, 111),
                                            fontSize: MediaQuery.of(context).size.width / 24)),
                                    Row(
                                      children: [
                                        Text("- Rs ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'GothamMedium',
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                fontSize: MediaQuery.of(context).size.width / 24)),
                                        Text("86",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'GothamMedium',
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                fontSize: MediaQuery.of(context).size.width / 24)),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          if (checkValue == true)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Gift",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'GothamMedium',
                                            color: Color.fromARGB(255, 71, 54, 111),
                                            fontSize: MediaQuery.of(context).size.width / 24)),
                                    Row(
                                      children: [
                                        Text("Rs ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'GothamMedium',
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                fontSize: MediaQuery.of(context).size.width / 24)),
                                        Text("300",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'GothamMedium',
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                fontSize: MediaQuery.of(context).size.width / 24)),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivery",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontSize: MediaQuery.of(context).size.width / 24)),
                              (delivery == false || totalAmt < 300)
                                  ? Text(
                                      "Free",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.rasa(
                                          textStyle: TextStyle(
                                              color: Color.fromARGB(255, 71, 54, 111),
                                              fontSize: MediaQuery.of(context).size.width / 24)),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          "Rs ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'GothamMedium',
                                              color: Color.fromARGB(255, 71, 54, 111),
                                              fontSize: MediaQuery.of(context).size.width / 24),
                                        ),
                                        Text("300",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'GothamMedium',
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                fontSize: MediaQuery.of(context).size.width / 24)),
                                      ],
                                    )
                            ],
                          )
                        ],
                      ),
                      Divider(
                        color: Color.fromARGB(255, 71, 54, 111),
                        height: 10,
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Amount ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontSize: MediaQuery.of(context).size.width / 24)),
                          Row(
                            children: [
                              Text(
                                " Rs",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    color: Color.fromARGB(255, 71, 54, 111),
                                    fontSize: MediaQuery.of(context).size.width / 24),
                              ),
                              Text("3949",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontSize: MediaQuery.of(context).size.width / 24)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                        child: Text("Confirm Order",
                            style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.width / 24)),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary:
                              totalAmt == 0.00 ? Colors.grey : Color.fromARGB(255, 71, 54, 111),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : EmptyCartPage(loginResponse, cartData);
  }
}

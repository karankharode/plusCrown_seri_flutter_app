import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seri_flutter_app/address/controller/AddressController.dart';
import 'package:seri_flutter_app/address/models/AddressData.dart';
import 'package:seri_flutter_app/address/models/UpdateAddressData.dart';
import 'package:seri_flutter_app/address/screens/add_address.dart';
import 'package:seri_flutter_app/address/screens/address-book.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/cart/models/DeleteFromCartData.dart';
import 'package:seri_flutter_app/common/screens/otp/main_otp.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/404builder.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/currentlyAvailable.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/networkImageBuilder.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/showFlushBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/showLoadingDialog.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

class CheckOutPage extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const CheckOutPage({this.loginResponse, this.cartData});
  @override
  _CheckOutPageState createState() =>
      _CheckOutPageState(loginResponse: loginResponse, cartData: cartData);
}

class _CheckOutPageState extends State<CheckOutPage> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _CheckOutPageState({this.loginResponse, this.cartData});
  bool finalSubmission = false;
  int step = 1;
  Size size;
  Future futureForCart;

  Future futureForAddress;
  var cartController = CartController();
  bool cartDataFetched = false;
  TextEditingController couponTextEditingController = new TextEditingController();
  bool apply = false;
  bool checkValue = false;
  String paymentMode = "null";

  AddressData addressData = null;
  String addId = null;

  bool delivery = true;

  @override
  void initState() {
    super.initState();
    futureForCart = cartController.getCartDetails(AddToCartData(
      // customerId: 27
      customerId: loginResponse.id,
    ));
    futureForAddress = AddressController().getAddress(loginResponse.id.toString());
    futureForCart.then((value) {
      setState(() {
        cartDataFetched = true;
      });
    });
  }

  handlePlaceOrder() async {
    showLoadingDialog(context);
    try{
    bool response = await cartController.placeOrder(
        OrderData(loginResponse.id.toString(), "First100", addressData.id.toString(), paymentMode));
    Navigator.pop(context);
    if (response) {
      showCustomFlushBar(context, "Order Placed", 2);
    } else {
      showCustomFlushBar(context, "Error Occured", 2);
    }
    Navigator.push(context, commonRouter(Otp_page(loginResponse, cartData)));
    }catch(e){
    print("remove this line at 86 in checkout");
    Navigator.pop(context);
    Navigator.push(context, commonRouter(Otp_page(loginResponse, cartData)));

    }
  }

  handleOrderConfirmation() {
    setState(() {
      step = 2;
    });
  }

  handleAddressSelection() {
    setState(() {
      step = 3;
      finalSubmission = true;
    });
  }
    String getType(String addType) {
    // DO changes from here
    switch (addType) {
      case "H":
        return "Home";
      case "O":
        return "Other";
      case "W":
        return "Work";
        break;
      default:
        return "";
    }
  }


  updateAddress(String addressId, AddressData newaddressData) {
    setState(() {
      addId = addressId;
      addressData = newaddressData;
    });
  }
  deleteAddress(addid) async {
    bool deleted = await AddressController().removeAddress(RemoveAddressData(add_id: addid));
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
        duration: Duration(seconds: 1),
      )..show(context).then((value) => setState(() {}));
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

  getGlobalCartData() async {
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    futureForCart.then((value) {
      setState(() {});
    });
  }

  deleteCartItem(productid) async {
    bool deleted = await CartController().removeFromCart(DeleteFromCartData(
        customerId:

            // 27,
            loginResponse.id,
        productId: productid));
    if (deleted) {
      getGlobalCartData();
      showCustomFlushBar(context, "Deleted Successfully", 2);

      // setState(() {});
    } else {
      showCustomFlushBar(context, "Error deleting from Cart", 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildTextAppBar(context, "Checkout", loginResponse, false, false, null),
      bottomNavigationBar: Container(
        height: 56,
        child: ElevatedButton(
          child: Text(!finalSubmission ? "Proceed" : "Place Order",
              style: TextStyle(
                  fontFamily: 'GothamMedium',
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 24)),
          onPressed: () {
            if (finalSubmission) {
              if (paymentMode != "null") {
                handlePlaceOrder();
                // Navigator.push(
                //     context,
                //     commonRouter((
                //       loginResponse: loginResponse,
                //       cartData: cartData,
                //       addressData: addressData,
                //     )));
              } else {
                showCustomFlushBar(context, "Select Payment Method", 2);
              }
            } else {
              switch (step) {
                case 1:
                  handleOrderConfirmation();
                  break;
                case 2:
                  handleAddressSelection();
                  break;
                default:
                  null;
              }
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 71, 54, 111),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                child: Column(
                  children: [
                    buildTopProgressbar(),
                    buildBodyForEachStep(step),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget buildBodyForEachStep(int step) {
    if (step == 1) {
      return buildOrderConfirmationPage();
    } else if (step == 2) {
      return buildAddressSelectionPage();
    } else if (step == 3) {
      return buildPaymentPage();
    } else {
      return notFoundBuilder(size.height / 1.5);
    }
  }

  Widget buildOrderConfirmationPage() {
    return FutureBuilder(
        future: futureForCart,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return bookLoader();
              break;
            case ConnectionState.done:
              CartData cartDataFromSnapshot = snapshot.data;
              List<CartProduct> cartList = cartDataFromSnapshot.cartProducts;
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(children: [
                  cartList.length != 0
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cartList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            CartProduct cartProduct = cartList[index];
                            return ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Card(
                                elevation: 0.0,
                                child: GestureDetector(
                                  // onTap: () {
                                  //   showLoadingDialog(context);
                                  //   Future futureForProductDetailsPage =
                                  //       ProductController().getProductById(cartProduct.productId);
                                  //   futureForProductDetailsPage.then((value) {
                                  //     Navigator.pop(context);
                                  //     Navigator.push(context, commonRouter(PageOne(value, loginResponse, cartData)));
                                  //   });
                                  // },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Container(
                                      // height: 179,
                                      width: MediaQuery.of(context).size.width - 15,
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
                                          border:
                                              Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 5),
                                                child: Row(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          alignment: Alignment.topLeft,
                                                          height: 100,
                                                          width: MediaQuery.of(context).size.width /
                                                              5.15,
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey[50],
                                                            borderRadius: BorderRadius.circular(5),
                                                            border: Border.all(color: Colors.black),
                                                            // image: DecorationImage(
                                                            //     image: NetworkImage(cartProduct.product_image),
                                                            //     fit: BoxFit.fill)
                                                          ),
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(5),
                                                              child: coverPageimageBuilder(
                                                                  cartProduct.product_image)),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 14),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                //   alignment: Alignment.topLeft,
                                                                width: MediaQuery.of(context)
                                                                        .size
                                                                        .width /
                                                                    1.7,
                                                                child: Text(
                                                                  cartProduct.productName,
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      fontFamily: 'GothamMedium',
                                                                      fontWeight: FontWeight.w600,
                                                                      fontSize:
                                                                          MediaQuery.of(context)
                                                                                  .size
                                                                                  .width /
                                                                              20,
                                                                      color: Color.fromARGB(
                                                                          255, 71, 54, 111)),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              if (cartProduct.product_isavailable ==
                                                                  true)
                                                                Container(
                                                                  // alignment: Alignment.center,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                    children: [
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          RichText(
                                                                            text: TextSpan(
                                                                                text: "\u20B9 ",
                                                                                style: TextStyle(
                                                                                    fontFamily:
                                                                                        'GothamMedium',
                                                                                    fontSize: MediaQuery.of(
                                                                                                context)
                                                                                            .size
                                                                                            .width /
                                                                                        27,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    color: Color
                                                                                        .fromARGB(
                                                                                            255,
                                                                                            71,
                                                                                            54,
                                                                                            111)),
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text: cartProduct
                                                                                        .productPrice,
                                                                                    style: TextStyle(
                                                                                        fontFamily:
                                                                                            'GothamMedium',
                                                                                        fontSize: MediaQuery.of(context)
                                                                                                .size
                                                                                                .width /
                                                                                            27,
                                                                                        color: Color
                                                                                            .fromARGB(
                                                                                                255,
                                                                                                71,
                                                                                                54,
                                                                                                111)),
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
                                                                                    fontFamily:
                                                                                        'GothamMedium',
                                                                                    fontSize: MediaQuery.of(
                                                                                                context)
                                                                                            .size
                                                                                            .width /
                                                                                        27,
                                                                                    decoration:
                                                                                        TextDecoration
                                                                                            .lineThrough,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    color: Color
                                                                                        .fromARGB(
                                                                                            255,
                                                                                            71,
                                                                                            54,
                                                                                            111)),
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text: cartProduct
                                                                                        .product_mrp,
                                                                                    style: TextStyle(
                                                                                        fontFamily:
                                                                                            'GothamMedium',
                                                                                        decoration:
                                                                                            TextDecoration
                                                                                                .lineThrough,
                                                                                        fontSize: MediaQuery.of(context)
                                                                                                .size
                                                                                                .width /
                                                                                            27,
                                                                                        color: Color
                                                                                            .fromARGB(
                                                                                                255,
                                                                                                71,
                                                                                                54,
                                                                                                111)),
                                                                                  )
                                                                                ]),
                                                                          ),
                                                                          SizedBox(
                                                                            width: 10,
                                                                          ),
                                                                          RichText(
                                                                            text: TextSpan(
                                                                                text: cartProduct
                                                                                    .product_discountoff,
                                                                                style: TextStyle(
                                                                                    fontFamily:
                                                                                        'GothamMedium',
                                                                                    fontSize: MediaQuery.of(
                                                                                                context)
                                                                                            .size
                                                                                            .width /
                                                                                        27,
                                                                                    // fontWeight: FontWeight.bold,
                                                                                    color: Colors
                                                                                        .green),
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text: "% Off",
                                                                                    style: TextStyle(
                                                                                        fontFamily:
                                                                                            'GothamMedium',
                                                                                        fontSize: MediaQuery.of(context)
                                                                                                .size
                                                                                                .width /
                                                                                            27,
                                                                                        color: Colors
                                                                                            .green),
                                                                                  )
                                                                                ]),
                                                                          ),
                                                                        ],
                                                                      ),

                                                                      // SizedBox(width: MediaQuery.of(context).size.width *0.2),
                                                                    ],
                                                                  ),
                                                                ),
                                                              if (cartProduct.product_isavailable ==
                                                                  false)
                                                                currentlyUnavailableBuilder()
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 6.0, bottom: 6),
                                              child: GestureDetector(
                                                onTap: () {
                                                  deleteCartItem(
                                                    cartProduct.productId,
                                                  );
                                                },
                                                child: Container(
                                                    height: 20,
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Color.fromARGB(255, 170, 54, 111),
                                                      size: 25,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  SizedBox(height: 10),
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
                            hintStyle: TextStyle(fontFamily: 'GothamMedium', color: Colors.grey),
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
                          Text("Cart Total",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontSize: MediaQuery.of(context).size.width / 24,
                              )),
                          Text("\u20B9 " + cartDataFromSnapshot.cart_mrp,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontSize: MediaQuery.of(context).size.width / 24)),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Cart Savings ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontSize: MediaQuery.of(context).size.width / 24)),
                          Text("- \u20B9 " + cartDataFromSnapshot.cart_saving,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontSize: MediaQuery.of(context).size.width / 24)),
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
                                    Text("- \u20B9 " + cartDataFromSnapshot.coupons_discount,
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
                                Text("\u20B9 " + " 300", // cartDataFromSnapshot.,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontSize: MediaQuery.of(context).size.width / 24)),
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
                          (delivery == false ||
                                  (int.tryParse(cartDataFromSnapshot.cartPrice) ?? 0 < 300))
                              ? Text(
                                  "Free",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.rasa(
                                      textStyle: TextStyle(
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context).size.width / 24)),
                                )
                              : Text(
                                  "\u20B9 " + cartDataFromSnapshot.cart_delivery,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontSize: MediaQuery.of(context).size.width / 24),
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
                      Text(
                        " \u20B9 " + cartDataFromSnapshot.cart_total_amount,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: Color.fromARGB(255, 71, 54, 111),
                            fontSize: MediaQuery.of(context).size.width / 24),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ]),
              );

              break;
            default:
              return bookLoader();
          }
        });
  }

  Widget buildAddressSelectionPage() {

    return  Container(
      height: MediaQuery.of(context).size.height-200,
      child: Stack(
        children: [
          Column(
            children: [
              FutureBuilder(
                  future: futureForAddress,
                  builder: (context, snapshot) {
                     switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return bookLoader();
                        break;
                      case ConnectionState.done:
                    if (snapshot.hasData) {
                      List<AddressData> addList = snapshot.data;
                      addList.forEach((element) {print(element.id);});
                      if (addList.length > 0) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: addList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleAddress(
                                  name: addList[index].name,
                                  phoneNo: "9635821475",
                                  pinCode: addList[index].addpincode,
                                  city: addList[index].city,
                                  district: addList[index].city,
                                  flatNo: addList[index].line1,
                                  area: addList[index].line2,
                                  landmark: addList[index].line3,
                                  type: getType(addList[index].addtype),
                                  add_id: addList[index].id.toString(),
                                  deleteAddress: deleteAddress,
                                  isDefault: addList[index].isdeafault,
                                  addressData: addList[index],
                                  updateAddressId: updateAddress
                                  , selected_add_id: addId,);
                            });
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                    break;
                    default:
                    return bookLoader();
                     }
                  }),
           
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Address(loginResponse, cartData)));
                  },
                  child: Row(
                    children: [
                      Container(
                          child: Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 71, 54, 111),
                        size: MediaQuery.of(context).size.width / 23,
                      )),
                      SizedBox(width: 4),
                      Text("Add new Address",
                          style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: Color.fromARGB(255, 71, 54, 111),
                            fontSize: MediaQuery.of(context).size.width / 23,
                          )),
                    ],
                  ),
                ),
            ],
          ),
        
            Positioned(
              bottom: 0,
              right: 10,
              child: Image.asset("assets/images/location.png",height: 45, width: 45),)
        ],
      ),
    );
  
  }

  Widget buildPaymentPage() {
    return Column(children: [

      Image.asset("assets/images/payments.jpg"),
      Text("Select the Payment method for placing Order",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'GothamMedium',
              color: Color.fromARGB(255, 71, 54, 111),
              fontSize: MediaQuery.of(context).size.width / 30)),
      SizedBox(height: 10),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  paymentMode = '2';
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.055,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  decoration: BoxDecoration(
                    color:
                        paymentMode == '2' ? Color.fromARGB(255, 71, 54, 111) : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                  ),
                  alignment: Alignment.center,
                  child: Text(" Online Payment ",
                      style: TextStyle(
                          fontFamily: 'GothamMedium',
                          color:
                              paymentMode == '2' ? Colors.white : Color.fromARGB(255, 71, 54, 111),
                          fontSize: MediaQuery.of(context).size.width / 25,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  paymentMode = '1';
                });
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AddressPhoneVerify()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.055,
                padding: EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  color: paymentMode == '1' ? Color.fromARGB(255, 71, 54, 111) : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                ),
                alignment: Alignment.center,
                child: Text(" Cash on Delivery ",
                    style: TextStyle(
                        fontFamily: 'GothamMedium',
                        color: paymentMode == '1' ? Colors.white : Color.fromARGB(255, 71, 54, 111),
                        fontSize: MediaQuery.of(context).size.width / 25,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
    ]);
  }

  Column buildTopProgressbar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 2, 15),
              child: Text(
                "Order Confirmation",
                style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
              ),
            )),
            Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Text(
                "Address",
                style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
              ),
            )),
            Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Text(
                "Payment",
                style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
              ),
            )),
          ],
        ),
        LinearProgressIndicator(
          color: kPrimaryColor,
          minHeight: 3.0,
          value: step * 0.34,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}

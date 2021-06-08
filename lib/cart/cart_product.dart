import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/counter_box.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/networkImageBuilder.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/showFlushBar.dart';
import 'package:seri_flutter_app/empty-wishlist/controller/wishListController.dart';
import 'package:seri_flutter_app/empty-wishlist/models/AddtoWishlistData.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:seri_flutter_app/my-order-detail-page/screens/myOrderDetailPage.dart';
import 'package:sizer/sizer.dart';
import '../empty-wishlist/wishlist/WishListPage.dart';
import 'models/CartData.dart';

// ignore_for_file: non_constant_identifier_names
class CartList extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;
  final Function deleteFunction;
  final Function giftCheck;

  const CartList(this.loginResponse, this.cartData, this.deleteFunction, this.giftCheck);

  @override
  _CartListState createState() => _CartListState(loginResponse, cartData);
}

class _CartListState extends State<CartList> {
  final LoginResponse loginResponse;
  final CartData cartData;

  bool productsLoaded = false;
  List cartList = [];

  _CartListState(this.loginResponse, this.cartData);

  @override
  void initState() {
    cartList = cartData.cartProducts;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // cartList == null?
        // Container(width: 0.0, height: 0.0,):
        cartList.length != 0
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cartList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return SingleOffer(
                    cartProduct: cartList[index],
                    loginResponse: loginResponse,
                    cartData: cartData,
                    deleteFunction: widget.deleteFunction,
                    giftCheck: widget.giftCheck,
                  );
                },
              )
            : Container(
                height: 0,
                width: 0,
              );
  }
}

class SingleOffer extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  final CartProduct cartProduct;
  final Function deleteFunction;
  final Function giftCheck;

  SingleOffer(
      {this.cartProduct, this.loginResponse, this.cartData, this.deleteFunction, this.giftCheck});

  @override
  _SingleOfferState createState() =>
      _SingleOfferState(loginResponse, cartData, deleteFunction, giftCheck);
}

class _SingleOfferState extends State<SingleOffer> {
  final LoginResponse loginResponse;
  final CartData cartData;
  final Function deleteFunction;
  final Function giftCheck;

  var productController;

  bool checkedValue = false;

  _SingleOfferState(this.loginResponse, this.cartData, this.deleteFunction, this.giftCheck);

  addToWishList(productId) async {
    bool response = await WishlistController()
        .addToWishlist(AddToWishlistData(customerId: loginResponse.id, productId: productId));

    if (response) {
      showCustomFlushBar(context, "Added Successfully", 2);
    } else {
      showCustomFlushBar(context, "Error Adding to WishList", 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Card(
        elevation: 0.0,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyOrdersDetailPage(
                          loginResponse: loginResponse,
                          cartData: cartData,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
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
                  border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
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
                              width: MediaQuery.of(context).size.width / 5,
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black),
                                // image: DecorationImage(
                                //     image: NetworkImage(widget.cartProduct.product_image),
                                //     fit: BoxFit.fill)
                              ),
                              child: coverPageimageBuilder(widget.cartProduct.product_image),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    //   alignment: Alignment.topLeft,
                                    width: MediaQuery.of(context).size.width / 1.7,
                                    child: Text(
                                      widget.cartProduct.productName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          fontWeight: FontWeight.w600,
                                          fontSize: MediaQuery.of(context).size.width / 20,
                                          color: Color.fromARGB(255, 71, 54, 111)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (widget.cartProduct.product_isavailable == true)
                                    Container(
                                      // alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
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
                                                        text: widget.cartProduct.productPrice,
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
                                                        text: widget.cartProduct.product_mrp,
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
                                                    text: widget.cartProduct.product_discountoff,
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
                                          // SizedBox(width: MediaQuery.of(context).size.width *0.2),
                                        ],
                                      ),
                                    ),
                                  if (widget.cartProduct.product_isavailable == false)
                                    Container(
                                      //  width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
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
                                              fontSize: MediaQuery.of(context).size.width / 22,
                                              color: Colors.red),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  widget.cartProduct.product_isavailable == true
                      ? Row(
                          //  crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 24,
                                  child: Transform.scale(
                                      scale: 1,
                                      child: Checkbox(
                                        activeColor: Color.fromARGB(255, 71, 54, 111),
                                        value: checkedValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkedValue = value;
                                          });
                                          giftCheck(value);
                                        },
                                      )),
                                ),
                                Text(
                                  "  Send this item as a Gift",
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      fontSize: 13,
                                      color: Color.fromARGB(255, 71, 54, 111)),
                                ),
                              ],
                            ),
                            CountButtonView(
                              initialCount: 1,
                              onChange: (count) {},
                            )
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 24,
                                  child: Transform.scale(
                                    scale: 1,
                                    child: Checkbox(
                                      value: checkedValue,
                                      activeColor: Color.fromARGB(255, 71, 54, 111),
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkedValue = false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  "  Send this item as a Gift",
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      fontSize: 13,
                                      color: Colors.grey[400]),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 2.0),
                                  child: SizedBox(
                                    height: 25,
                                    width: MediaQuery.of(context).size.width * 0.25,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xddFFFFFF),
                                          border: Border.all(color: Colors.grey[400], width: 1.0),
                                          borderRadius: BorderRadius.circular(5.0)),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              width: (MediaQuery.of(context).size.width * 0.25) / 3,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 2.0),
                                                child: Container(
                                                    width:
                                                        (MediaQuery.of(context).size.width * 0.25) /
                                                            3,
                                                    child: Center(
                                                        child: Icon(Icons.remove,
                                                            color: Colors.grey[400]))),
                                              )),
                                          Text("|", style: TextStyle(color: Colors.grey[400])),
                                          Container(
                                            child: Center(
                                                child: Text(
                                              '1',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[400],
                                                  decoration: TextDecoration.none),
                                            )),
                                          ),
                                          Text("|", style: TextStyle(color: Colors.grey[400])),
                                          Container(
                                              width: (MediaQuery.of(context).size.width * 0.25) / 3,
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 2.0),
                                                child: Container(
                                                    width:
                                                        (MediaQuery.of(context).size.width * 0.25) /
                                                            3,
                                                    child: Center(
                                                        child: Icon(Icons.add,
                                                            color: Colors.grey[400]))),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                )
                              ],
                            )
                          ],
                        ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 71, 54, 111),
                    height: 10,
                    thickness: 1,
                  ),
                  //  SizedBox(height: 1.5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 7.0, bottom: 4, top: 4),
                        child: GestureDetector(
                          onTap: () {
                            addToWishList(widget.cartProduct.productId);
                          },
                          child: Text(
                            "Add to WishList",
                            style: TextStyle(
                                fontFamily: 'GothamMedium',
                                fontSize: 12.sp,
                                color: Color.fromARGB(255, 71, 54, 111)),
                          ),
                        ),
                      ),
                      // SizedBox(width: MediaQuery.of(context).size.width ,),
                      Padding(
                        padding: const EdgeInsets.only(right: 6.0, bottom: 6),
                        child: GestureDetector(
                          onTap: () => deleteFunction(widget.cartProduct.productId, false),
                          child: Container(
                              height: 20,
                              child: Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 170, 54, 111),
                                size: 25,
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

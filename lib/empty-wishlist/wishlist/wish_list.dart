import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/empty-wishlist/controller/wishListController.dart';
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

  bool productsLoaded = false;

  var wishList = [];

  @override
  Widget build(BuildContext context) {
    // if (!productsLoaded) {
    //   const productCategory = 'Dairy';
    //   var requestUrl = backendCustomerGetProducts + productCategory;
    //   final response = http.post(requestUrl);
    //   var jsonData;
    //   response.then((value) {
    //     jsonData = json.decode(value.body.toString());
    //     print(jsonData);
    //     setState(() {
    //       prodList = jsonData['Products'];
    //       productsLoaded = true;
    //     });
    //     print(prodList);
    //   });
    // }
    return FutureBuilder(
        future: WishlistController()
            .getWishlistDetails(GetWishlistData(customerId: widget.loginResponse.id)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            WishlistData wishListData = snapshot.data;

            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
                break;
              case ConnectionState.done:
                return Flexible(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: wishListData.wishlistProducts.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleProdWL(
                              prodName: wishListData.wishlistProducts[index].productName,
                              //cartList[index]['productName'],
                              // TODO: Set images for the product
                              image: "assets/images/first_page.png",
                              //    image: offer_list[index]['image'],
                              percentOff: "30",
                              //cartList[index]['offerPercentage'],
                              actual_price: "1600",
                              //cartList[index]['price'],
                              final_price: wishListData.wishlistProducts[index].productPrice,
                              available: true);
                        }));
                break;
              default:
                return CircularProgressIndicator();
            }
          } else {
            return Flexible(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleProdWL(
                          prodName: "Standart 8th Textbook",
                          //cartList[index]['productName'],
//              TODO: Set images for the product
                          image: "assets/images/first_page.png",
                          //    image: offer_list[index]['image'],
                          percentOff: "30",
                          //cartList[index]['offerPercentage'],
                          actual_price: "1600",
                          //cartList[index]['price'],
                          final_price: "699",
                          available: true);
                    }));
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
  final String prodName;
  final image;
  final String percentOff;
  final String actual_price;
  final String final_price;
  final available;
  final LoginResponse loginResponse;

  SingleProdWL(
      {this.prodName,
      this.image,
      this.percentOff,
      this.actual_price,
      this.final_price,
      this.available,
      this.loginResponse});

  @override
  _SingleProdWLState createState() => _SingleProdWLState();
}

class _SingleProdWLState extends State<SingleProdWL> {
  bool productDeleted = false;
  bool checkedValue = false;
  addProductToCart(AddToCartData addToCartData) async {
    bool response = await CartController().addToCart(addToCartData);
    print(response);
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
    return productDeleted
        ? Container(
            height: 0,
            width: 0,
          )
        : ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 6, 4, 6),
              child: Container(
                // height: 160,
                width: MediaQuery.of(context).size.width - 11,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8, left: 8, bottom: 5),
                      child: Row(
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 135,
                                    width: MediaQuery.of(context).size.width / 3.5,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        //  borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.black),
                                        image: DecorationImage(
                                            //  image: AssetImage(widget.image),
                                            image: AssetImage(widget.image),
                                            fit: BoxFit.fill)),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 5.0,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width / 50,
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              width: MediaQuery.of(context).size.width / 2.5,
                                              //  height: 30,
                                              child: Text(
                                                widget.prodName,
                                                style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontSize:
                                                        MediaQuery.of(context).size.width / 25,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromARGB(255, 71, 54, 111)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          // alignment: Alignment.topRight,
                                          child: PopupMenuButton(
                                            itemBuilder: (BuildContext bc) => [
                                              PopupMenuItem(
                                                  child: Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                        fontFamily: 'GothamMedium',
                                                        fontWeight: FontWeight.w600,
                                                        color: Color.fromARGB(255, 71, 54, 111)),
                                                  ),
                                                  value: "1"),
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
                                            onSelected: (value) {},
                                            // onSelected: (route) {
                                            //   Navigator.pushNamed(context, route);
                                            // },
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
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.start,
                                              //crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  //    crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  //   mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                          text: "Rs ",
                                                          style: TextStyle(
                                                              fontFamily: 'GothamMedium',
                                                              fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  27,
                                                              // fontWeight: FontWeight.bold,
                                                              color:
                                                                  Color.fromARGB(255, 71, 54, 111)),
                                                          children: [
                                                            TextSpan(
                                                              text: widget.final_price,
                                                              style: TextStyle(
                                                                  fontFamily: 'GothamMedium',
                                                                  fontSize: MediaQuery.of(context)
                                                                          .size
                                                                          .width /
                                                                      27,
                                                                  color: Color.fromARGB(
                                                                      255, 71, 54, 111)),
                                                            )
                                                          ]),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                          text: "Rs ",
                                                          style: TextStyle(
                                                              fontFamily: 'GothamMedium',
                                                              fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  27,
                                                              decoration:
                                                                  TextDecoration.lineThrough,
                                                              // fontWeight: FontWeight.bold,
                                                              color:
                                                                  Color.fromARGB(255, 71, 54, 111)),
                                                          children: [
                                                            TextSpan(
                                                              text: widget.actual_price,
                                                              style: TextStyle(
                                                                  fontFamily: 'GothamMedium',
                                                                  decoration:
                                                                      TextDecoration.lineThrough,
                                                                  fontSize: MediaQuery.of(context)
                                                                          .size
                                                                          .width /
                                                                      27,
                                                                  color: Color.fromARGB(
                                                                      255, 71, 54, 111)),
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
                                                              fontSize: MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  27,
                                                              // fontWeight: FontWeight.bold,
                                                              color: Colors.green),
                                                          children: [
                                                            TextSpan(
                                                              text: "% Off",
                                                              style: TextStyle(
                                                                  fontFamily: 'GothamMedium',
                                                                  fontSize: MediaQuery.of(context)
                                                                          .size
                                                                          .width /
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
                                                      fontSize:
                                                          MediaQuery.of(context).size.width / 29,
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
                                                        borderRadius:
                                                            BorderRadius.all(Radius.circular(8))),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Text(
                                                        "  Unavailable  ",
                                                        style: TextStyle(
                                                            fontFamily: 'GothamMedium',
                                                            fontSize:
                                                                MediaQuery.of(context).size.width /
                                                                    23,
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
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width / 4.5,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context).size.height / 25,
                                              // alignment: Alignment.bottomRight,
                                              child: ElevatedButton(
                                                child: Text("Add to cart",
                                                    style: TextStyle(
                                                        fontFamily: 'GothamMedium',
                                                        color: Colors.white,
                                                        fontSize:
                                                            MediaQuery.of(context).size.width /
                                                                25)),
                                                onPressed: () {
                                                  AddToCartData add = new AddToCartData(
                                                    customerId: widget.loginResponse.id,
                                                    productId: 42,
                                                  );
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
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

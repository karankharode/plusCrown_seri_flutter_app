import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/common/widgets/ProductScreenWidgets.dart';
import 'package:seri_flutter_app/common/widgets/appBars/buildAppBarWithSearch.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/horizontalProductList.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/data/title.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:seri_flutter_app/return&exchange/screens/return_and_exchange_policy.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
// ignore_for_file: non_constant_identifier_names
class PageOne extends StatefulWidget {
  final ProductData myProduct;
  final LoginResponse loginResponse;
  final CartData cartData;

  PageOne(this.myProduct, this.loginResponse, this.cartData);

  @override
  _PageOneState createState() =>
      _PageOneState(myProduct: myProduct, loginResponse: loginResponse, cartData: cartData);
}

class _PageOneState extends State<PageOne> {
  final ProductData myProduct;
  final LoginResponse loginResponse;
  final CartData cartData;

  _PageOneState({this.loginResponse, this.cartData, this.myProduct});

  bool _btn1 = true;
  bool _btn2 = false;
  bool wishlist = false;
  bool binding = false;
  String _currentImage = "";

  var productController;
  Future futureForProducts;
  Future futureForCart;
  var cartController;
  bool search = false;
  int currentIndex = 0;

  showLoaderForShare() {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: "Downloading !",
        builder: (_) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Lottie.asset(
                        'assets/animations/sharingRocket.json',
                        width: 180,
                        height: 180,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Downloading !",
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: kPrimaryColor.withOpacity(0.7),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                ),
              ));
        });
  }

  Future<Null> saveAndShare(url, productName) async {
    showLoaderForShare();
    String imageName = "Plus_Crown_Shared_${DateTime.now().toString()}";
    final RenderBox box = context.findRenderObject();
    // if (Platform.isAndroid) {
    var response = await get(url);
    final documentDirectory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = new File('$documentDirectory/$imageName.png');
    imgFile.writeAsBytesSync(response.bodyBytes);

    Share.shareFiles([
      '$documentDirectory/$imageName.png',
    ],
        subject: 'Plus Crown Product Sharing',
        text:
            'Checkout the $productName on the Plus Crown App !\nTo Download the App from PlayStore Click on the Link Below :\nLink...',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    Navigator.pop(context);
    // }
    // else {
    //   Share.shareFiles([
    //     '$documentDirectory/flutter.png',
    //   ],
    //       subject: 'Plus Crown Product Sharing',
    //       text: 'Checkout the ',
    //       sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    // }
    // setState(() {
    //   isBtn2 = false;
    // });
  }

  @override
  void initState() {
    productController = Provider.of<ProductController>(context, listen: false);
    cartController = Provider.of<CartController>(context, listen: false);
    futureForProducts =
        productController.getProductBySubCategory(new ProductData(catId: "1", subCatId: "1"));
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> _image_list = [myProduct.img, myProduct.img1, myProduct.img2, myProduct.img3];

    addProductToCart(AddToCartData addToCartData) async {
      bool response = await cartController.addToCart(addToCartData);
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

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: search == false
          ? buildAppBarWithSearch(context, loginResponse, () {
              setState(() {
                search = true;
              });
            })
          : null,
      drawer: CustomDrawer(loginResponse, cartData),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          search == true
              ? Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.1,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                      ),
                    ),
                    Positioned(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding * 0.8,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 0.5,
                        ),
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: kDefaultPadding,
                              ),
                              child: Image.asset(
                                'assets/images/search.png',
                                width: size.width * 0.06,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  // contentPadding:
                                  //     EdgeInsets.only(top: kDefaultPadding * 0.05),
                                  hintText: "SEARCH PRODUCTS",
                                  hintStyle: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    color: kPrimaryColor.withOpacity(0.5),
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  search = false;
                                });
                              },
                              child: Image.asset(
                                'assets/images/cross_purple.png',
                                width: size.width * 0.06,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Container(
                  height: 0.0,
                  width: 0.0,
                ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding),
                  child: Text(
                    myProduct.title,
                    style: TextStyle(
                        fontFamily: 'GothamMedium',
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // height: size.height * 0.065,
                          // width: size.width * 0.065,
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              myProduct.discount_per + "%",
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: size.height * 0.3,
                            width: size.width * 0.6,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                String url;
                                if (_currentImage == "") {
                                  url = myProduct.img;
                                } else {
                                  url = _currentImage;
                                }
                                Navigator.push(
                                    context,
                                    commonRouter(FullScreenImage(
                                      imgList: _image_list,
                                      currentIndex: currentIndex,
                                      imgUrl: url,
                                    )));
                              },
                              child: Center(
                                child: PinchZoom(
                                  image: CachedNetworkImage(
                                    imageUrl: _currentImage == "" ? myProduct.img : _currentImage,
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                  zoomedBackgroundColor: Colors.black.withOpacity(0.5),
                                  resetDuration: const Duration(milliseconds: 100),
                                  maxScale: 2.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.3,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    wishlist = wishlist == false ? true : false;
                                  });
                                },
                                child: Container(
                                  child: wishlist == true
                                      ? Image.asset(
                                          'assets/images/wishlisted.png',
                                          width: MediaQuery.of(context).size.width * 0.1,
                                        )
                                      : Image.asset(
                                          'assets/images/wishlist.png',
                                          width: MediaQuery.of(context).size.width * 0.1,
                                        ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  saveAndShare(
                                      Uri.parse(myProduct.img), myProduct.title.toString());
                                },
                                child: Image.asset(
                                  'assets/icons/share.png',
                                  width: size.width * 0.07,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = 0;
                              _currentImage = _image_list[0];
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                            height: size.height * 0.2,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: myProduct.img,
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = 1;
                              _currentImage = _image_list[1];
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                            height: size.height * 0.2,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: myProduct.img1,
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = 2;
                              _currentImage = _image_list[2];
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                            height: size.height * 0.2,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: myProduct.img2,
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = 3;
                              _currentImage = _image_list[3];
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                            height: size.height * 0.2,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: myProduct.img3,
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '\u20B9',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontFamily: 'GothamMedium',
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          children: [
                            TextSpan(
                              text: myProduct.price,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontFamily: 'GothamMedium',
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            TextSpan(text: " "),
                            TextSpan(
                              text: myProduct.mrp,
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17),
                            ),
                            TextSpan(text: " "),
                            TextSpan(
                              text: "(" + myProduct.discount_per + '%' + "Off" + ")",
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Price inclusive of all taxes",
                        style:
                            TextStyle(fontFamily: 'GothamMedium', color: Colors.red, fontSize: 15),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: kDefaultPadding,
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Color.fromARGB(255, 71, 54, 111),
                        value: this.binding,
                        onChanged: (bool value) {
                          setState(() {
                            this.binding = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Flexible(
                      child: Container(
                        child: Text('Add Book Binding',
                            style: TextStyle(
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'GothamMedium',
                            )),
                      ),
                    )
                  ],
                ),
                Divider(
                  height: kDefaultPadding,
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Details",
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Best quality product",
                              style: TextStyle(
                                  fontFamily: 'GothamMedium', fontSize: 15, color: kPrimaryColor),
                            ),
                            Text(
                              "Pages",
                              style: TextStyle(
                                  fontFamily: 'GothamMedium', fontSize: 15, color: kPrimaryColor),
                            ),
                            Text(
                              "Back Cover",
                              style: TextStyle(
                                  fontFamily: 'GothamMedium', fontSize: 15, color: kPrimaryColor),
                            ),
                            Text(
                              "Posters",
                              style: TextStyle(
                                  fontFamily: 'GothamMedium', fontSize: 15, color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: kDefaultPadding,
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Description",
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: kDefaultPadding / 2,
                          left: kDefaultPadding / 2,
                          right: kDefaultPadding / 2,
                        ),
                        child: Text(
                          myProduct.desp,
                          style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: kPrimaryColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: kDefaultPadding,
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Returns",
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding / 2,
                          vertical: kDefaultPadding / 2,
                        ),
                        child: myProduct.isReturnable == true
                            ? RichText(
                                text: TextSpan(
                                  text:
                                      'Easy 10 days return and exchange. Return policies may vary based on products, for complete details on our Return policies, please ',
                                  style: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    color: kPrimaryColor,
                                    fontSize: 15,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Click Here",
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).push(commonRouter(
                                              ReturnAndExchangePolicy(
                                                  loginResponse: loginResponse,
                                                  cartData: cartData)));
                                        },
                                      style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  text: 'No Returns available on this Product',
                                  style: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    color: kPrimaryColor,
                                    fontSize: 15,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Click Here",
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ReturnAndExchangePolicy()));
                                        },
                                      style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: kDefaultPadding,
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                ),
                TitleHome(
                  title: 'You may also Like',
                ),
                FutureBuilder(
                    future: futureForProducts,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ProductData> proList = snapshot.data;
                        return buildHorizontalProductList(size, proList, loginResponse, cartData);
                      } else {
                        return Container();
                      }
                    }),
                Divider(
                  height: kDefaultPadding,
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                ),
                TitleHome(
                  title: 'Similar Products',
                ),
                FutureBuilder(
                    future: futureForProducts,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ProductData> proList = snapshot.data;
                        return buildHorizontalProductList(size, proList, loginResponse, cartData);
                      } else {
                        return Container();
                      }
                    }),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: size.width,
        height: size.height * 0.08,
        decoration: BoxDecoration(
          border: Border.all(
            color: kPrimaryColor.withOpacity(0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                // setState(() {
                //   AddToCartData add = new AddToCartData(
                //     customerId: loginResponse.id,
                //     productId: myProduct.id,
                //   );
                //   addProductToCart(add);
                // });
              },
              child: Container(
                margin: EdgeInsets.only(left: 2, right: 2, bottom: 2),
                padding: EdgeInsets.all(1.0),
                height: MediaQuery.of(context).size.height * 0.045,
                width: MediaQuery.of(context).size.width * 0.35,
                child: MaterialButton(
                  onPressed: () {
                    AddToCartData add = new AddToCartData(
                      customerId: loginResponse.id,
                      productId: myProduct.id,
                    );
                    addProductToCart(add);
                  },
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 0.2.w),
                      borderRadius: BorderRadius.circular(5)),
                  textColor: Colors.white,
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                      color: Color.fromARGB(255, 71, 54, 111),
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(1.0),
                height: MediaQuery.of(context).size.height * 0.045,
                width: MediaQuery.of(context).size.width * 0.35,

                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {},
                  color: Color.fromARGB(255, 71, 54, 111),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color.fromARGB(255, 71, 54, 111), width: 0.2.w),
                      borderRadius: BorderRadius.circular(5)),
                  textColor: Colors.white,
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
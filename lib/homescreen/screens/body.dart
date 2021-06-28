import 'dart:math';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intent/category.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/searchScreen/SearchScreen.dart';
import 'package:seri_flutter_app/common/services/productListServices/productListSortService.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/subCategoryBuilder.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/data/product_data.dart';
import 'package:seri_flutter_app/homescreen/data/title.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/homescreen/others/biography_screen.dart';
import 'package:seri_flutter_app/homescreen/others/books.dart';
import 'package:seri_flutter_app/homescreen/others/competitve_screen.dart';
import 'package:seri_flutter_app/homescreen/others/stationary.dart';
import 'package:seri_flutter_app/homescreen/others/story_screen.dart';
import 'package:seri_flutter_app/listing-pages/screens/8_std_page.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../constants.dart';

class Body extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Body(this.loginResponse, this.cartData);

  @override
  _BodyState createState() => _BodyState(cartData, loginResponse);
}

class _BodyState extends State<Body> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _BodyState(this.cartData, this.loginResponse);

  var productController;
  Future futureForProducts;
  Future futureForStoryTellers;
  Future futureForBiography;
  Future futureForNotebooks;
  Future futureForStationary;
  TextEditingController _queryController = TextEditingController();
  bool fetched = false;

  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";

  var box;
  List favList = [];

  initHive() async {
    box = Hive.box('favBox');

    List localFavList = box.get('favList');
    print(localFavList);
    print(localFavList == []);
    if (localFavList != null) favList = localFavList;
  }

  // ignore: unused_field
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    // print(
    // "Received listener status: $status, listening: ${speech.isListening}");
    setState(() {
      lastStatus = "$status";
    });
  }

  void initSpeech() async {
    bool hasSpeech = await speech.initialize(onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }
    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  bool first = false;

  void startListening() {
    lastWords = "";
    lastError = "";
    showDialog(
        context: context,
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
                        'assets/animations/listen.json',
                        // width: 180,
                        // height: 180,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ));
        });
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 10),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: false,
        onDevice: true,
        pauseFor: Duration(seconds: 2),
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) {
    // _playVoice(result.recognizedWords.toString());
    setState(() {
      // Input can be shown here
      _queryController.text = result.recognizedWords;
    });
    Navigator.pop(context);
    FocusScope.of(context).requestFocus();
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  getFutureForProducts() {
    futureForProducts =
        productController.getProductBySubCategory(new ProductData(catId: "1", subCatId: "1"));
    futureForProducts.then((value) {
      setState(() {
        fetched = true;
      });
    });
  }

  @override
  void initState() {
    initSpeech();
    initHive();
    productController = Provider.of<ProductController>(context, listen: false);
    futureForStoryTellers =
        productController.getProductByCategory(new ProductData(category_id: 10));
    futureForBiography = productController.getProductByCategory(new ProductData(category_id: 9));
    futureForNotebooks = productController.getProductByCategory(new ProductData(category_id: 8));
    futureForStationary = productController.getProductByCategory(new ProductData(category_id: 7));
    getFutureForProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: size.height * 0.055,
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //  alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 1.1,
                  // vertical: kDefaultPadding * 0.8,
                ),
                padding: EdgeInsets.only(left: kDefaultPadding * 0.4),
                height: size.height * 0.044,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: kDefaultPadding / 3,
                      ),
                      child: Image.asset(
                        'assets/images/search.png',
                        width: size.width * 0.056,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _queryController,
                        textAlign: TextAlign.left,
                        onEditingComplete: () {
                          Navigator.push(
                              context,
                              commonRouter(
                                  SearchScreen(loginResponse, cartData, _queryController.text)));
                          // print(_queryController.text);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 11, top: 11),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: IconButton(
                        onPressed: !_hasSpeech || speech.isListening ? null : startListening,
                        icon: Image.asset(
                          'assets/images/mic.png',
                          width: size.width * 0.06,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        fetched
            ? Expanded(
                child: ListView(
                children: [
                  Stack(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 1.6,
                        vertical: kDefaultPadding / 1.9,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4.27,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: new Carousel(
                            boxFit: BoxFit.cover,
                            images: [
                              getCorouselWidget(context, "assets/banners/Stationary.gif",
                                  Stationary(loginResponse: loginResponse, cartData: cartData)),
                              getCorouselWidget(
                                  context,
                                  "assets/banners/11th Standard.gif",
                                  ListingPageForClasses(
                                    loginResponse: loginResponse,
                                    cartData: cartData,
                                    above10th: true,
                                    catId: "3",
                                  )),
                              getCorouselWidget(
                                  context,
                                  "assets/banners/12th Standard.gif",
                                  ListingPageForClasses(
                                    loginResponse: loginResponse,
                                    cartData: cartData,
                                    above10th: true,
                                    catId: "4",
                                  )),
                              getCorouselWidget(context, "assets/banners/Competitive.gif",
                                  Competitive(loginResponse, cartData)),
                              getCorouselWidget(context, "assets/banners/NoteBook.gif",
                                  Books(loginResponse, cartData)),
                              // AssetImage("assets/icons/9th standard.png"),
                            ],
                            autoplay: true,
                            autoplayDuration: Duration(seconds: 6),
                            animationCurve: Curves.easeIn,
                            animationDuration: Duration(milliseconds: 800),
                            indicatorBgPadding: 2,
                            dotSize: 2,
                          ),
                        ),
                      ),
                      //     child: ClipRRect(
                      //       child: CarouselSlider(
                      //         options: CarouselOptions(),
                      //         items: imgList
                      //             .map((item) => Container(
                      //                   child: Image.asset(
                      //                     item,
                      //                     fit: BoxFit.fill,
                      //                   ),
                      //                 ))
                      //             .toList(),
                      //       ),
                      //     )
                      //     ),
                    ),

                    // Positioned(
                    //   right: MediaQuery.of(context).size.width / 14,
                    //   bottom: MediaQuery.of(context).size.height / 20,
                    //   // right: 28,
                    //   // bottom: 28,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.of(context).push(commonRouter(ListingPageForClasses(
                    //         loginResponse: loginResponse,
                    //         cartData: cartData,
                    //         above10th: true,
                    //         catId: "1",
                    //       )));
                    //     },
                    //     child: Container(
                    //       height: size.height * 0.05,
                    //       width: 80,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         color: kPrimaryColor,
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           'Buy Now',
                    //           style: TextStyle(
                    //             fontFamily: 'GothamMedium',
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ]),
                  SizedBox(height: 8),
                  FutureBuilder(
                      future: futureForProducts,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                          case ConnectionState.active:
                            return Container();
                          case ConnectionState.done:
                            if (snapshot.hasData) {
                              List<ProductData> proList = snapshot.data;
                              // logic pending
                              List<ProductData> newArrivalList = getNewArrivalsList(proList);
                              List<ProductData> dealsOftheDayList = getDealsOftheDayList(proList);
                              List<ProductData> bestSellerList = getBestSellersList(proList);
                              // logic pending
                              List<ProductData> recentlyViewedList = getRecentlyViewedList(proList);

                              if (proList.length > 0) {
                                return Column(
                                  children: [
                                    newArrivalList.length > 0
                                        ? buildCategoryProductList(
                                            context,
                                            size,
                                            newArrivalList,
                                            "New Arrivals",
                                            "1",
                                            "1",
                                            loginResponse,
                                            cartData,
                                          )
                                        : Container(),
                                    dealsOftheDayList.length > 0
                                        ? buildCategoryProductList(
                                            context,
                                            size,
                                            dealsOftheDayList,
                                            'Deal of the Day',
                                            "1",
                                            "1",
                                            loginResponse,
                                            cartData,
                                          )
                                        : Container(),
                                    bestSellerList.length > 0
                                        ? buildCategoryProductList(
                                            context,
                                            size,
                                            bestSellerList,
                                            'Best Sellers',
                                            "1",
                                            "1",
                                            loginResponse,
                                            cartData,
                                          )
                                        : Container(),
                                    recentlyViewedList.length > 0
                                        ? buildCategoryProductList(
                                            context,
                                            size,
                                            recentlyViewedList,
                                            'Recently Viewed',
                                            "1",
                                            "1",
                                            loginResponse,
                                            cartData,
                                          )
                                        : Container(),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                            break;
                          default:
                            return Container();
                        }
                      }),

                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 1.6,
                        vertical: kDefaultPadding / 1.9,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4.27,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: Image.asset(
                            "assets/banners/Deal.gif",
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  SizedBox(height: 10),

                  // story teller

                  buildCategoryRowsHomePage(size, 10, 'Story Tellers', futureForStoryTellers),
                  buildCategoryRowsHomePage(size, 9, 'Biography Books', futureForBiography),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 1.6,
                      vertical: kDefaultPadding / 1.9,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4.27,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: new Carousel(
                          boxFit: BoxFit.cover,
                          images: [
                            getCorouselWidget(context, "assets/banners/StoryTeller.gif",
                                Story(loginResponse, cartData)),
                            getCorouselWidget(
                                context,
                                "assets/banners/8th Standard.gif",
                                ListingPageForClasses(
                                  loginResponse: loginResponse,
                                  cartData: cartData,
                                  above10th: false,
                                  catId: "1",
                                )),
                            getCorouselWidget(
                                context,
                                "assets/banners/9th Standard.gif",
                                ListingPageForClasses(
                                  loginResponse: loginResponse,
                                  cartData: cartData,
                                  above10th: false,
                                  catId: "2",
                                )),
                            getCorouselWidget(
                                context,
                                "assets/banners/10th Standard.gif",
                                ListingPageForClasses(
                                  loginResponse: loginResponse,
                                  cartData: cartData,
                                  above10th: false,
                                  catId: "5",
                                )),
                            getCorouselWidget(
                                context,
                                "assets/banners/Biography.gif",
                                Biography(
                                  loginResponse: loginResponse,
                                  cartData: cartData,
                                )),
                            // AssetImage("assets/icons/9th standard.png"),
                          ],
                          autoplay: true,
                          autoplayDuration: Duration(seconds: 6),
                          animationCurve: Curves.easeIn,
                          animationDuration: Duration(milliseconds: 800),
                          indicatorBgPadding: 2,
                          dotSize: 2,
                        ),
                      ),
                    ),
                    //     child: ClipRRect(
                    //       child: CarouselSlider(
                    //         options: CarouselOptions(),
                    //         items: imgList
                    //             .map((item) => Container(
                    //                   child: Image.asset(
                    //                     item,
                    //                     fit: BoxFit.fill,
                    //                   ),
                    //                 ))
                    //             .toList(),
                    //       ),
                    //     )
                    //     ),
                  ),
                  buildCategoryRowsHomePage(size, 8, 'NoteBooks', futureForNotebooks),
                  buildCategoryRowsHomePage(size, 7, 'Stationary', futureForStationary),

                  TitleHome(
                    title: 'Shop By Brand',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: size.height * 0.06,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: brands.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                // top: kDefaultPadding,
                                // bottom: kDefaultPadding,
                                right: kDefaultPadding,
                                left: kDefaultPadding),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    commonRouter(SearchScreen(
                                        loginResponse, cartData, brands[index]['keyWord'])));
                              },
                              child: Image.asset(
                                brands[index]['image'],
                                // width: size.width * 0.3,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 2,
                    ),
                    height: 2,
                    color: kPrimaryColor,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: kDefaultPadding,
                    ),
                    child: Center(
                      child: Text(
                        '" An Investment in knowledge pays best interest "',
                        style: TextStyle(
                          fontFamily: 'GothamMedium',
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ))
            : bookLoader(),
      ],
    );
  }

  FutureBuilder<dynamic> buildCategoryRowsHomePage(
      Size size, int category_id, String title, future) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
            case ConnectionState.active:
              return Container();
            case ConnectionState.done:
              if (snapshot.hasData) {
                List<ProductData> proList = snapshot.data;

                if (proList.length > 0) {
                  return Column(
                    children: [
                      proList.length > 0
                          ? buildCategoryProductList(context, size, proList, title,
                              category_id.toString(), "1", loginResponse, cartData,
                              future: future)
                          : Container(),
                    ],
                  );
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
              break;
            default:
              return Container();
          }
        });
  }

  GestureDetector getCorouselWidget(BuildContext context, String asset, destination) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, commonRouter(destination));
        },
        child: Image.asset(
          asset,
          fit: BoxFit.cover,
        ));
  }
}

import 'dart:math';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/services/productListServices/productListSortService.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/subCategoryBuilder.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/data/product_data.dart';
import 'package:seri_flutter_app/homescreen/data/title.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/listing-pages/screens/8_std_page.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';

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
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";
  // ignore: unused_field
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  _BodyState(this.cartData, this.loginResponse);

  var productController;
  Future futureForProducts;
  TextEditingController _queryController = TextEditingController();
  bool fetched = false;

  _playVoice(String message) {
    _voiceController.init().then((_) {
      _voiceController.speak(
        message,
        VoiceControllerOptions(),
      );
    });
  }

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

  VoiceController _voiceController;
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
    _playVoice(result.recognizedWords.toString());
    setState(() {
      // Input can be shown here
      _queryController.text = result.recognizedWords;
    });
    Navigator.pop(context);
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
    super.initState();
    initSpeech();
    productController = Provider.of<ProductController>(context, listen: false);
    getFutureForProducts();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: size.height * 0.065,
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
                height: size.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: kDefaultPadding / 3,
                      ),
                      child: Image.asset(
                        'assets/images/search.png',
                        width: size.width * 0.06,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _queryController,
                        decoration: InputDecoration(
                          // contentPadding: EdgeInsets.all(kDefaultPadding * 0.05),
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
                physics: BouncingScrollPhysics(),
                children: [
                  Stack(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding / 1.6,
                        vertical: kDefaultPadding / 2,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: new Carousel(
                            boxFit: BoxFit.cover,
                            images: [
                              AssetImage("assets/icons/9th standard.png"),
                              AssetImage("assets/icons/banner.png"),
                              AssetImage("assets/icons/9th standard.png"),
                              AssetImage("assets/icons/banner.png"),
                              AssetImage("assets/icons/9th standard.png"),
                            ],
                            autoplay: true,
                            autoplayDuration: Duration(seconds: 4),
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
                    Positioned(
                      right: MediaQuery.of(context).size.width / 14,
                      bottom: MediaQuery.of(context).size.height / 20,
                      // right: 28,
                      // bottom: 28,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(commonRouter(ListingPageForClasses(
                            loginResponse: loginResponse,
                            cartData: cartData,
                            above10th: true,
                            catId: "1",
                          )));
                        },
                        child: Container(
                          height: size.height * 0.05,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor,
                          ),
                          child: Center(
                            child: Text(
                              'Buy Now',
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                            child: Image.asset(
                              brands[index],
                              // width: size.width * 0.3,
                              fit: BoxFit.fitHeight,
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
}
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/404builder.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/data/product_list.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchScreen extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;
  final String keyword;
  const SearchScreen(this.loginResponse, this.cartData, this.keyword);

  @override
  _SearchScreenState createState() => _SearchScreenState(loginResponse, cartData);
}

class _SearchScreenState extends State<SearchScreen> {
  final LoginResponse loginResponse;
  final CartData cartData;
  bool search = false;
  _SearchScreenState(this.loginResponse, this.cartData);

  String searchKeyWord;
  Future futureForSearch;
  TextEditingController _searchController;
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
    Navigator.pop(context);
    _searchController.text = result.recognizedWords;
    searchKeyWord = _searchController.text;
    futureForSearch = ProductController().getProductByKeyword(searchKeyWord);
    setState(() {});
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  @override
  void initState() {
    super.initState();
    initSpeech();
    searchKeyWord = widget.keyword;
    _searchController = TextEditingController(text: widget.keyword);
    futureForSearch = ProductController().getProductByKeyword(widget.keyword);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 56, //size.height * 0.13,
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: 10,
                ),
                padding: EdgeInsets.only(left: kDefaultPadding * 0.5),
                height: size.height * 0.044,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kPrimaryColor, width: 1),
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        controller: _searchController,
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          searchKeyWord = _searchController.text;
                          futureForSearch = ProductController().getProductByKeyword(searchKeyWord);
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 11),
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
                    // GestureDetector(
                    //   onTap: () => _searchController.clear(),
                    //   child: Image.asset(
                    //     'assets/images/cross_purple.png',
                    //     width: size.width * 0.06,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(2.5.w, 0.w, 2.5.w, 0),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                      height: 2.5.w,
                    ),
                    Text(
                      "Showing Results for - " + searchKeyWord ?? " ",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'GothamMedium',
                      ),
                    ),
                    SizedBox(height:2),
                    FutureBuilder(
                        future: futureForSearch,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                            case ConnectionState.active:
                              return bookLoader();
                              break;
                            case ConnectionState.done:
                              if (snapshot.hasData) {
                                List<ProductData> prolist = snapshot.data;
                                if (prolist.isNotEmpty) {
                                  return Container(
                                      // height: (prolist.length / 2) * ((size.width / 2.8) * 2),
                                      child: GridView.count(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 2.9,
                                    mainAxisSpacing: 5.0,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                    physics: NeverScrollableScrollPhysics(),
                                    children: [...getProducts(prolist, loginResponse, cartData)],
                                  ));
                                } else {
                                  return notFoundBuilder(570.0);
                                }
                              } else {
                                return notFoundBuilder(570.0);
                              }
                              break;
                            default:
                              return bookLoader();
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getProducts(proListnew, loginResponse, cartData) {
    List<Widget> products = [];
    for (ProductData product in proListnew) {
      // products.add(Container(height: 40, color: Colors.blue));
      products.add(ProductList(product, loginResponse, cartData));
    }
    return products;
  }
}

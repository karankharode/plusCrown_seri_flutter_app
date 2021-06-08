import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/searchScreen/SearchScreen.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchBar extends StatefulWidget {
  final BuildContext context;
  final Size size;
  final Function crossAction;
  final LoginResponse loginResponse;
  final CartData cartData;

  const SearchBar(this.context, this.size, this.crossAction, this.loginResponse, this.cartData);
  @override
  _SearchBarState createState() =>
      _SearchBarState(this.context, this.size, this.crossAction, this.loginResponse, this.cartData);
}

class _SearchBarState extends State<SearchBar> {
  final BuildContext context;
  final Size size;
  final Function crossAction;
  final LoginResponse loginResponse;
  final CartData cartData;

  _SearchBarState(this.context, this.size, this.crossAction, this.loginResponse, this.cartData);

  TextEditingController _searchController = TextEditingController();

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
    // _playVoice(result.recognizedWords.toString());
    setState(() {
      // Input can be shown here
      _searchController.text = result.recognizedWords;
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

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  @override
  Widget build(BuildContext searchCtx) {
    return SafeArea(
      child: Container(
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
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kPrimaryColor, width: 1),
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: kDefaultPadding,
                  ),
                  child: Image.asset(
                    'assets/images/search.png',
                    width: size.width * 0.056,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    onEditingComplete: () {
                      Navigator.push(
                          context,
                          commonRouter(
                              SearchScreen(loginResponse, cartData, _searchController.text)));
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
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: !_hasSpeech || speech.isListening ? null : startListening,
                    // icon: Icon(Icons.mic),
                    icon: Image.asset(
                      'assets/images/mic.png',
                      width: size.width * 0.06,
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: crossAction,
                //   child: Image.asset(
                //     'assets/images/cross_purple.png',
                //     width: size.width * 0.06,
                //   ),
                // ),
              ],
            ),
          )),
    );
  }
}

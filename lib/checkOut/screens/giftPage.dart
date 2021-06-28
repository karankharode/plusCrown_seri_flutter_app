import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

class GiftPage extends StatefulWidget {
  int count;
  final LoginResponse loginResponse;
  final CartData cartData;
  final String gift_msg;
  final String gift_from;
  final String giftFromName;
  final Function saveFunction;

  GiftPage(
      {this.count,
      @required this.loginResponse,
      this.cartData,
      this.saveFunction,
      this.giftFromName,
      @required this.gift_msg,
      this.gift_from});

  @override
  _GiftPageState createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> {
  bool checkValue = false;
  TextEditingController _fromKey;
  TextEditingController _msgKey;

  @override
  void initState() {
    super.initState();
    _fromKey = TextEditingController(text: widget.giftFromName);
    _msgKey = TextEditingController(text: widget.gift_msg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTextAppBar(context, "Gift Card/Wrap", null, false, false, null),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text("Add Gift Message",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: 'GothamMedium',
                          color: Color.fromARGB(255, 71, 54, 111),
                          fontSize: MediaQuery.of(context).size.width / 24)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      onPressed: () {
                        widget.count = widget.count - 1;
                        Navigator.pop(context);
                        // if (widget.count != 0) {
                        //   Navigator.push(
                        //       context,
                        //       commonRouter(GiftPage(
                        //         count: widget.count,
                        //         loginResponse: widget.loginResponse,
                        //         cartData: widget.cartData,
                        //         gift_msg: widget.gift_msg + "***" + _msgKey.text,
                        //         gift_from: widget.loginResponse.id.toString(),
                        //       )));
                        // } else {
                        //   Navigator.push(
                        //       context,
                        //       commonRouter(CheckOutPage(
                        //         loginResponse: widget.loginResponse,
                        //         cartData: widget.cartData,
                        //         gift_msg: widget.gift_msg + "***" + _msgKey.text,
                        //         gift_from: widget.loginResponse.id.toString(),
                        //       )));
                        // }
                      },
                      icon: Icon(Icons.cancel, color: Colors.grey)),
                )
              ],
            ),
            Image.asset(
              "assets/images/giftCard.jpg",
              height: 400,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text("Give your Best Wishes to Your Loved Ones",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: 'GothamMedium',
                          color: Colors.red,
                          fontSize: MediaQuery.of(context).size.width / 24)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              // height: 250,
              width: MediaQuery.of(context).size.width - 15,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                                controller: _msgKey,
                                textAlign: TextAlign.start,
                                maxLines: 4,

                                //   controller:
                                // couponTextEditingController,
                                style: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    color: Color.fromARGB(255, 71, 54, 111),
                                    fontWeight: FontWeight.w500,
                                    fontSize: MediaQuery.of(context).size.width / 22),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: ' Gift Message',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'GothamMedium',
                                    color: Color.fromARGB(255, 71, 54, 111),
                                  ),
                                  labelStyle:
                                      TextStyle(fontSize: MediaQuery.of(context).size.width / 24),
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
                                  Text("   From:  ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context).size.width / 24)),
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
                                        height: MediaQuery.of(context).size.height * 0.02,
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height / 30,
                                        width: MediaQuery.of(context).size.width - 150,
                                        child: TextFormField(
                                          controller: _fromKey,
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                          //   controller: couponTextEditingController,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'GothamMedium',
                                              color: Color.fromARGB(255, 71, 54, 111),
                                              fontSize: MediaQuery.of(context).size.width / 22),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '',
                                            hintStyle: TextStyle(
                                              fontFamily: 'GothamMedium',
                                              fontWeight: FontWeight.w300,
                                              color: Color.fromARGB(255, 71, 54, 111),
                                            ),
                                            labelStyle: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width / 22),
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
                      SizedBox(height: 15),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width / 30,
                              width: MediaQuery.of(context).size.width / 30,
                              child: Transform.scale(
                                scale: 1,
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
                                        fontSize: MediaQuery.of(context).size.width / 29,
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
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 24.0),
                          //   child: Icon(Icons.wallet_giftcard,
                          //       color: Colors.redAccent,
                          //       size: MediaQuery.of(context).size.height / 18),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 8.0),
                          //   child: ElevatedButton(
                          //     child: Text("See Details",
                          //         style: TextStyle(
                          //             fontFamily: 'GothamMedium',
                          //             color: Colors.red,
                          //             fontSize: MediaQuery.of(context).size.width / 25)),
                          //     onPressed: () {},
                          //     style: ElevatedButton.styleFrom(
                          //       primary: Colors.white,
                          //       elevation: 1,
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //           side: BorderSide(color: Colors.black54, width: 0.5)),
                          //     ),
                          //   ),
                          // )
                        ],
                      )
                    ]),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 56,
        child: ElevatedButton(
          child: Text("Save",
              // widget.count == 1 ? "Proceed to Checkout" : "Save & Continue",
              style: TextStyle(
                  fontFamily: 'GothamMedium',
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 24)),
          onPressed: () {
            widget.count = widget.count - 1;
            widget.saveFunction(_msgKey.text, _fromKey.text);
            Navigator.pop(context); // if (widget.count != 0) {
            //   Navigator.push(
            //       context,
            //       commonRouter(GiftPage(
            //         count: widget.count,
            //         loginResponse: widget.loginResponse,
            //         cartData: widget.cartData,
            //         gift_msg: widget.gift_msg + "***" + _msgKey.text,
            //         gift_from: widget.loginResponse.id.toString(),
            //       )));
            // } else {
            //   Navigator.push(
            //       context,
            //       commonRouter(CheckOutPage(
            //         loginResponse: widget.loginResponse,
            //         cartData: widget.cartData,
            //         gift_msg: widget.gift_msg + "***" + _msgKey.text,
            //         gift_from: widget.loginResponse.id.toString(),
            //       )));
            // }
          },
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 71, 54, 111),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/services/Form/textFieldDecoration.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/showFlushBar.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:seri_flutter_app/requestBook/controller.dart';
import 'package:seri_flutter_app/requestBook/modelBook.dart';
import 'package:sizer/sizer.dart';

import 'package:image_picker/image_picker.dart';

class RequestBook extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const RequestBook(this.loginResponse, this.cartData);
  @override
  _RequestBookState createState() => _RequestBookState(loginResponse, cartData);
}

class _RequestBookState extends State<RequestBook> {
  final LoginResponse loginResponse;
  final CartData cartData;
  bool checkedUrgent = false;

  final formKey = GlobalKey<FormState>();
  SizedBox gapBox = SizedBox(
    height: kDefaultPadding,
  );
  String bookType;
  String _relatedTo;
  String email;
  File _image;
  int requiredDays;
  final picker = ImagePicker();

  TextEditingController nameTextEditingController = new TextEditingController();
  TextEditingController customerNameTextEditingController = new TextEditingController();
  TextEditingController descriptionTextEditingController = new TextEditingController();
  TextEditingController numberTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController requiredDaysEditingController = new TextEditingController();
  TextEditingController authorNameEditingController = new TextEditingController();

  _RequestBookState(this.loginResponse, this.cartData);

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future placeRequest() async {
    bool response = await BookRequestController().placeRequest(RequestedBook(
        nameTextEditingController.text,
        bookTypeMap[bookType],
        relatedToMap[_relatedTo],
        descriptionTextEditingController.text,
        // _image,
        requiredDaysEditingController.text,
        customerNameTextEditingController.text,
        numberTextEditingController.text,
        emailTextEditingController.text,
        checkedUrgent,
        authorNameEditingController.text));
    if (response) {
      showCustomFlushBar(context, "Request Placed", 2);
    } else {
      showCustomFlushBar(context, "Error Occured", 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle formFieldTextStyle = TextStyle(
      color: kPrimaryColor,
      fontFamily: 'GothamMedium',
      fontSize: MediaQuery.of(context).size.width / 22,
    );
    return Scaffold(
      appBar: buildTextAppBar(context, "Request Book", loginResponse, false, false, null),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 5, 15, 0),
              child: Column(
                children: [
                  gapBox,
                  TextFormField(
                    controller: nameTextEditingController,
                    validator: (val) {
                      return val.length > 2 ? null : " Please provide name";
                    },
                    decoration: getInputDecoration("Book Name"),
                  ),
                  gapBox,
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        border: Border.all(color: Color.fromARGB(255, 71, 54, 111))),
                    child: DropdownButton<String>(
                      focusColor: Colors.white,
                      value: bookType,
                      isExpanded: true,
                      elevation: 4,
                      underline: Container(
                        height: 0,
                        color: Colors.white,
                      ),
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: kPrimaryColor,
                      items: <String>[
                        "TextBook",
                        "Reference Book",
                        "Study Material",
                        "Novel",
                        "Story Books / Biography Books",
                        "Others",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            "     " + value,
                            style: TextStyle(
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontSize: 16,
                              fontFamily: 'GothamMedium',
                            ),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "     Please select Book type",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          bookType = value;
                        });
                      },
                    ),
                  ),
                  gapBox,
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        border: Border.all(color: Color.fromARGB(255, 71, 54, 111))),
                    child: DropdownButton<String>(
                      focusColor: Colors.white,
                      value: _relatedTo,
                      isExpanded: true,
                      elevation: 4,
                      underline: Container(
                        height: 0,
                        color: Colors.white,
                      ),
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: kPrimaryColor,
                      items: <String>[
                        "State Board",
                        "CBSE Board",
                        "ICSE Board",
                        "Entrance Exams",
                        "For Book Readers",
                        "Others",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            "     " + value,
                            style: TextStyle(
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontSize: 16,
                              fontFamily: 'GothamMedium',
                            ),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "     Book Related To",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _relatedTo = value;
                        });
                      },
                    ),
                  ),
                  gapBox,
                  TextFormField(
                    controller: descriptionTextEditingController,
                    cursorColor: Color.fromARGB(255, 71, 54, 111),
                    maxLength: 150,
                    minLines: 1,
                    maxLines: 6,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    validator: (val) {
                      return val.length > 2 ? null : "  Please provide description";
                    },
                    decoration: getInputDecoration("Book Description"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 150,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            border: Border.all(color: kPrimaryColor)),
                        child: _image == null
                            ? Center(
                                child: IconButton(
                                    onPressed: getImage,
                                    icon: Icon(Icons.add_photo_alternate_outlined)),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                child: Image.file(
                                  _image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 165,
                            height: 55,
                            child: TextFormField(
                              controller: requiredDaysEditingController,
                              keyboardType: TextInputType.number,
                              cursorColor: Color.fromARGB(255, 71, 54, 111),
                              decoration: getInputDecoration("Book Required in days"),
                            ),
                          ),
                          gapBox,
                          Container(
                            width: MediaQuery.of(context).size.width - 165,
                            height: 55,
                            child: TextFormField(
                              controller: authorNameEditingController,
                              keyboardType: TextInputType.number,
                              cursorColor: Color.fromARGB(255, 71, 54, 111),
                              decoration: getInputDecoration("Author Name"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  gapBox,
                  TextFormField(
                    controller: customerNameTextEditingController,
                    cursorColor: Color.fromARGB(255, 71, 54, 111),
                    validator: (val) {
                      return val.length > 2 ? null : " Please provide name";
                    },
                    decoration: getInputDecoration("Your Name"),
                  ),
                  gapBox,
                  TextFormField(
                    controller: numberTextEditingController,

                    cursorColor: Color.fromARGB(255, 71, 54, 111),
                    // style: formFieldTextStyle,
                    validator: (val) {
                      return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(val)
                          ? null
                          : "Please provide valid number";
                    },
                    decoration: getInputDecoration("Your Number"),
                  ),
                  gapBox,
                  TextFormField(
                    controller: emailTextEditingController,
                    cursorColor: Color.fromARGB(255, 71, 54, 111),
                    validator: (val) {
                      return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(val) ||
                              RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                      r"{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(val)
                          ? null
                          : "Please provide valid number or Email ID";
                    },
                    decoration: getInputDecoration("Your Email Address"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Checkbox(
                          checkColor: Colors.white,
                          activeColor: Color.fromARGB(255, 71, 54, 111),
                          value: this.checkedUrgent,
                          onChanged: (bool value) {
                            setState(() {
                              this.checkedUrgent = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Flexible(
                        child: Container(
                          child: Text('I need this book urgently',
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
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    padding: EdgeInsets.only(top: 0, left: 0),
                    height: MediaQuery.of(context).size.height / 18,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )),
                    child: MaterialButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) placeRequest();
                      },
                      color: Color.fromARGB(255, 71, 54, 111),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        "Place Book Request",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            )),
      ),
    );
  }
}

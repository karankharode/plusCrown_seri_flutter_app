import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/address/controller/AddressController.dart';
import 'package:seri_flutter_app/address/models/AddAddressData.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/services/Form/textFieldDecoration.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import '../../constants.dart';

class Address extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const Address(this.loginResponse, this.cartData);

  @override
  _AddressState createState() => _AddressState(loginResponse, cartData);
}

class _AddressState extends State<Address> {
  final LoginResponse loginResponse;
  final CartData cartData;

  var cartController = CartController();

  final formKey = GlobalKey<FormState>();

  addAddress(AddAddressData addAddressData) async {
    bool response = await AddressController().addAddress(addAddressData);
    print(response);
    if (response) {
      // showCustomFlushBar(context, "Added Successfully", 2);
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
      )..show(context).then((value) => Navigator.pop(context));
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

  TextEditingController nameTextEditingController = new TextEditingController();
  TextEditingController numberTextEditingController = new TextEditingController();
  TextEditingController pinCodeTextEditingController = new TextEditingController();
  TextEditingController cityTextEditingController = new TextEditingController();
  TextEditingController flatNoTextEditingController = new TextEditingController();
  TextEditingController areaTextEditingController = new TextEditingController();
  TextEditingController landmarkTextEditingController = new TextEditingController();
  TextEditingController districtTextEditingController = new TextEditingController();

  int _radioValue1 = 0;
  String addressType = 'H';

  _AddressState(this.loginResponse, this.cartData);

  void _handleRadioValueChange1(int value) {
    _radioValue1 = value;

    switch (_radioValue1) {
      case 0:
        setState(() => addressType = 'H');
        break;
      case 1:
        setState(() => addressType = 'O');
        break;
      case 2:
        setState(() => addressType = 'W');
        break;
    }
  }

  bool checkValue = false;

  SizedBox gapBox = SizedBox(
    height: kDefaultPadding,
  );

  @override
  Widget build(BuildContext context) {
    TextStyle formFieldTextStyle = TextStyle(
      color: Color.fromARGB(255, 71, 54, 111),
      fontFamily: 'GothamMedium',
      fontSize: MediaQuery.of(context).size.width / 22,
    );
    return Scaffold(
        appBar: buildTextAppBar(context, "Add Address", loginResponse, false, false, null),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 18, bottom: 1),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Contact Info",
                          style: TextStyle(
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontFamily: 'GothamMedium',
                              fontSize: MediaQuery.of(context).size.width / 18,
                              fontWeight: FontWeight.bold))),
                  gapBox,
                  TextFormField(
                    controller: nameTextEditingController,
                    style: formFieldTextStyle,
                    validator: (val) {
                      return val.length > 2 ? null : "Please provide name";
                    },
                    decoration: getInputDecoration("Name"),
                  ),
                  gapBox,
                  TextFormField(
                      validator: (val) {
                        return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(val)
                            ? null
                            : "Please provide valid number";
                      },
                      controller: numberTextEditingController,
                      style: formFieldTextStyle,
                      decoration: getInputDecoration('Phone Number')),
                  gapBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Address Info",
                          style: TextStyle(
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontFamily: 'GothamMedium',
                              fontSize: MediaQuery.of(context).size.width / 19,
                              fontWeight: FontWeight.bold))),
                  gapBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: TextFormField(
                              validator: (val) {
                                return RegExp(r'(^[1-9][0-9]{5}$)').hasMatch(val)
                                    ? null
                                    : "Please provide valid PinCode";
                              },
                              controller: pinCodeTextEditingController,
                              style: formFieldTextStyle,
                              decoration: getInputDecoration('PinCode'),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 20,
                          )
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: TextFormField(
                          validator: (val) {
                            return val.isEmpty || val.length < 2
                                ? "Please Provide valid city"
                                : null;
                          },
                          controller: cityTextEditingController,
                          style: formFieldTextStyle,
                          decoration: getInputDecoration('City'),
                        ),
                      ),
                    ],
                  ),
                  gapBox,
                  TextFormField(
                    validator: (val) {
                      return val.isEmpty || val.length < 2 ? "Please Provide valid District" : null;
                    },
                    controller: districtTextEditingController,
                    style: formFieldTextStyle,
                    decoration: getInputDecoration('District'),
                  ),
                  gapBox,
                  TextFormField(
                    validator: (val) {
                      return val.isEmpty ? "Please Provide Flat No / Building Name " : null;
                    },
                    controller: flatNoTextEditingController,
                    style: formFieldTextStyle,
                    decoration: getInputDecoration('Flat No/Building Name'),
                  ),
                  gapBox,
                  TextFormField(
                    validator: (val) {
                      return val.isEmpty ? "Please Provide Locality / Area / Street " : null;
                    },
                    controller: areaTextEditingController,
                    style: formFieldTextStyle,
                    decoration: getInputDecoration('Locality/Area/Street'),
                  ),
                  gapBox,
                  TextFormField(
                    controller: landmarkTextEditingController,
                    style: formFieldTextStyle,
                    decoration: getInputDecoration('Landmark(Optional)'),
                  ),
                  gapBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Type of Address",
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontSize: MediaQuery.of(context).size.width / 19,
                              fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Radio(
                        activeColor: Color.fromARGB(255, 71, 54, 111),
                        value: 0,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
                      ),
                      new Text('Home',
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontSize: MediaQuery.of(context).size.width / 20)),
                      new Radio(
                        activeColor: Color.fromARGB(255, 71, 54, 111),
                        value: 1,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
                      ),
                      new Text('Office',
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontSize: MediaQuery.of(context).size.width / 20)),
                      new Radio(
                        activeColor: Color.fromARGB(255, 71, 54, 111),
                        value: 2,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
                      ),
                      new Text('Other',
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontSize: MediaQuery.of(context).size.width / 20)),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 3.0),
                          child: SizedBox(
                            height: 7,
                            width: 7,
                            child: Transform.scale(
                              scale: 1,
                              child: Checkbox(
                                value: checkValue,
                                activeColor: Color.fromARGB(255, 71, 54, 111),
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
                        Text("  Mark as default Address",
                            style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontSize: MediaQuery.of(context).size.width / 21)),
                      ]),
                  SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                    child: Text("Save Address",
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 21)),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        addAddress(AddAddressData(
                            addPincode: pinCodeTextEditingController.text,
                            addType: addressType.toString(),
                            city: cityTextEditingController.text,
                            customer_id: loginResponse.id,
                            name: nameTextEditingController.text,
                            line1: flatNoTextEditingController.text,
                            line2:
                                areaTextEditingController.text + landmarkTextEditingController.text,
                            line3: districtTextEditingController.text,
                            isdeafault: checkValue));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => AddressBookPage(loginResponse, cartData)));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 71, 54, 111),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

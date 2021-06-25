import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:seri_flutter_app/address/controller/AddressController.dart';
import 'package:seri_flutter_app/address/models/AddressData.dart';
import 'package:seri_flutter_app/address/models/UpdateAddressData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

// ignore_for_file: non_constant_identifier_names
class AddressBook extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;
  final Function updateAddress;
  final String selected_add_id;

  AddressBook(this.loginResponse, this.cartData, this.updateAddress, this.selected_add_id);

  @override
  _AddressBookState createState() => _AddressBookState(loginResponse, cartData);
}

class _AddressBookState extends State<AddressBook> {
  final LoginResponse loginResponse;
  final CartData cartData;

  bool addressLoaded = false;

  var addressList = [];

  _AddressBookState(this.loginResponse, this.cartData);

  var addressController;

  // Add controller and get Address details

  String getType(String addType) {
    // DO changes from here
    switch (addType) {
      case "H":
        return "Home";
      case "O":
        return "Other";
      case "W":
        return "Work";
        break;
      default:
        return "";
    }
  }

  deleteAddress(addid) async {
    Alert(
      context: context,
      title: "Do you want to Delete an Address ?",
      style: AlertStyle(overlayColor: Colors.black.withOpacity(0.4)),
      buttons: [
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          width: 120,
          color: Color.fromARGB(255, 71, 54, 111),
        ),
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            bool deleted =
                await AddressController().removeAddress(RemoveAddressData(add_id: addid));
            if (deleted) {
              Flushbar(
                margin: EdgeInsets.all(8),
                borderRadius: 8,
                message: "Deleted Successfully",
                icon: Icon(
                  Icons.info_outline,
                  size: 20,
                  color: Colors.lightBlue[800],
                ),
                duration: Duration(seconds: 1),
              )..show(context).then((value) => setState(() {}));
            } else {
              Flushbar(
                margin: EdgeInsets.all(8),
                borderRadius: 8,
                message: "Error deleting Address",
                icon: Icon(
                  Icons.info_outline,
                  size: 20,
                  color: Colors.lightBlue[800],
                ),
                duration: Duration(seconds: 2),
              )..show(context);
            }

            Navigator.pop(context);
          },
          width: 120,
          color: Color.fromARGB(255, 71, 54, 111),
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AddressController().getAddress(loginResponse.id.toString()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return bookLoader();
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                List<AddressData> addList = snapshot.data;
                if (addList.length > 0) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: addList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleAddress(
                          name: addList[index].name,
                          phoneNo: "9635821475",
                          pinCode: addList[index].addpincode,
                          city: addList[index].city,
                          district: addList[index].city,
                          flatNo: addList[index].line1,
                          area: addList[index].line2,
                          landmark: addList[index].line3,
                          type: getType(addList[index].addtype),
                          add_id: addList[index].id.toString(),
                          deleteAddress: deleteAddress,
                          isDefault: addList[index].isdeafault,
                          addressData: addList[index],
                          updateAddressId: widget.updateAddress,
                          selected_add_id: widget.selected_add_id,
                        );
                      });
                } else {
                  return Container();
                }
              } else {
                return Container();
              }
              break;
            default:
              return bookLoader();
          }
        });
  }
}

class SingleAddress extends StatefulWidget {
  final String name;
  final String phoneNo;
  final String pinCode;
  final String city;
  final flatNo;
  final String area;
  final String landmark;
  final String add_id;
  final String selected_add_id;
  final type;
  final district;
  final isDefault;
  final Function deleteAddress;
  final Function updateAddressId;
  final AddressData addressData;

  SingleAddress(
      {@required this.selected_add_id,
      this.name,
      this.phoneNo,
      this.pinCode,
      this.city,
      this.district,
      this.area,
      this.landmark,
      this.type,
      this.flatNo,
      this.add_id,
      this.deleteAddress,
      this.isDefault,
      this.updateAddressId,
      this.addressData});

  @override
  _SingleAddressState createState() => _SingleAddressState();
}

class _SingleAddressState extends State<SingleAddress> {
  final LoginResponse loginResponse;

  _SingleAddressState({this.loginResponse});

  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 15,
      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  SizedBox(
                    height: 8,
                    width: 8,
                    child: Transform.scale(
                      scale: 1,
                      child: Checkbox(
                        activeColor: Color.fromARGB(255, 71, 54, 111),
                        value: widget.selected_add_id == widget.add_id,
                        onChanged: (newValue) {
                          setState(() {
                            checkValue = newValue;
                          });
                          widget.updateAddressId(widget.add_id, widget.addressData);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(" " + widget.name,
                      style: TextStyle(
                          fontFamily: 'GothamMedium',
                          color: Color.fromARGB(255, 71, 54, 111),
                          fontSize: MediaQuery.of(context).size.width / 18))
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Align(
                    // alignment: Alignment.topRight,
                    child: Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.highlight_remove_rounded,
                      color: Colors.grey,
                    ),
                    onPressed: () => widget.deleteAddress(widget.add_id),
                  ),
                )
                    // child: PopupMenuButton(
                    //   itemBuilder: (BuildContext bc) => [
                    //     // PopupMenuItem(
                    //     //     child: Text(
                    //     //       "Edit",
                    //     //       style: TextStyle(
                    //     //           fontFamily: 'GothamMedium',
                    //     //           fontWeight: FontWeight.w600,
                    //     //           color: Color.fromARGB(255, 71, 54, 111)),
                    //     //     ),
                    //     //     value: "1"),
                    //     PopupMenuItem(
                    //         child: Text(
                    //           "Delete",
                    //           style: TextStyle(
                    //               fontFamily: 'GothamMedium',
                    //               fontWeight: FontWeight.w600,
                    //               color: Color.fromARGB(255, 71, 54, 111)),
                    //         ),
                    //         value: "2"),
                    //   ],
                    //   onSelected: (value) {
                    //     switch (value) {
                    //       case "2":
                    //         widget.deleteAddress(widget.add_id);

                    //         break;
                    //       default:
                    //         break;
                    //     }
                    //   },
                    //   // onSelected: (route) {
                    //   //   Navigator.pushNamed(context, route);
                    //   // },
                    // ),
                    ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.isDefault)
                    Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Default Address",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: 'GothamMedium',
                                  fontSize: MediaQuery.of(context).size.width / 26,
                                ))),
                        SizedBox(height: 6),
                      ],
                    ),
                  SizedBox(height: 4),
                  Text("Plot no. - " + widget.flatNo + ", " + widget.area + ", ",
                      //  textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          color: Color.fromARGB(255, 71, 54, 111),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'GothamMedium',
                          fontSize: MediaQuery.of(context).size.width / 27)),
                  if (widget.landmark != null)
                    Text(widget.landmark + ", ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: Color.fromARGB(255, 71, 54, 111),
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width / 27)),
                  SizedBox(height: 4),
                  Text("City - " + widget.city + ", " + "Dist - " + widget.district + ", ",
                      //  textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'GothamMedium',
                          color: Color.fromARGB(255, 71, 54, 111),
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width / 27)),
                  SizedBox(height: 4),
                  Text("PinCode - " + widget.pinCode,
                      //  textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'GothamMedium',
                          color: Color.fromARGB(255, 71, 54, 111),
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width / 27)),
                  SizedBox(height: 4),
                  Text("Phone Number - " + widget.phoneNo,
                      style: TextStyle(
                          fontFamily: 'GothamMedium',
                          color: Color.fromARGB(255, 71, 54, 111),
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width / 27))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

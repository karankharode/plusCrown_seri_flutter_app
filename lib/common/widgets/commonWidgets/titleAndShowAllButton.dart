import 'package:flutter/material.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/homescreen/others/showView.dart';
import 'package:sizer/sizer.dart';

Padding buildTitleandShowAllRow(
    BuildContext context, title, loginResponse, cartData, catId, subCatId) {
  return Padding(
    padding: EdgeInsets.only(
      right: 4.w,
      left: 4.w,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title.split('-').first ?? title,
            style: TextStyle(
              fontFamily: 'GothamMedium',
              color: Color.fromARGB(255, 71, 54, 111),
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.03,
          width: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 71, 54, 111),
            borderRadius: BorderRadius.circular(10),
            border: Border(
              bottom: BorderSide(color: Colors.black),
              top: BorderSide(color: Colors.black),
              left: BorderSide(color: Colors.black),
              right: BorderSide(color: Colors.black),
            ),
          ),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width * 0.02,
            height: MediaQuery.of(context).size.height * 0.02,
            onPressed: () {
              Navigator.of(context).push(commonRouter(ShowView(
                title: title,
                loginResponse: loginResponse,
                cartData: cartData,
                catId: catId,
                subcatId: subCatId,
              )));
            },
            color: Color.fromARGB(255, 71, 54, 111),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Show all",
              style: TextStyle(
                fontFamily: 'GothamMedium',
                fontWeight: FontWeight.w600,
                fontSize: 8.0.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

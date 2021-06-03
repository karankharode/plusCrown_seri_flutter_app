import 'package:flutter/material.dart';
import 'package:seri_flutter_app/common/widgets/appBars/cartwithBadge.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

AppBar buildTextAppBar(
    BuildContext context, title, LoginResponse loginResponse, bool leading, bool actions) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    leading: leading
        ? GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'assets/icons/leftarrowwhite.png',
                width: MediaQuery.of(context).size.width * 0.07,
              ),
            ),
          )
        : null,
    title: Text(
      title,
      style: TextStyle(fontFamily: 'GothamMedium', fontSize: 16.sp),
    ),
    actions: actions
        ? [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/search3.png',
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  cartwithBadge(loginResponse),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ]
        : null,
  );
}

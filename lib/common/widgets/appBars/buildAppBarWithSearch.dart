import 'package:flutter/material.dart';
import 'package:seri_flutter_app/common/widgets/appBars/cartwithBadge.dart';

import '../../../constants.dart';

// bool search;
AppBar buildAppBarWithSearch(
  BuildContext context,
  loginResponse,
  searchAction,
) {
  return AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: Color.fromARGB(255, 71, 54, 111),
    titleSpacing: 0,
    title: Image.asset(
      'assets/Logo/Plus Crown 1.png',
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height * 0.07,
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: searchAction,
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
    ],
  );
}

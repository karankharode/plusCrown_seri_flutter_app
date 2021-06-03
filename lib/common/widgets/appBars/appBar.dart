import 'package:flutter/material.dart';
import 'package:seri_flutter_app/common/widgets/appBars/cartwithBadge.dart';

import '../../../constants.dart';

AppBar buildAppBar(BuildContext context, loginResponse) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    elevation: 0,
    actions: [
      Padding(
        padding: EdgeInsets.only(right: kDefaultPadding),
        child: cartwithBadge(loginResponse),
      ),
    ],
    titleSpacing: 0,
    title: Image.asset(
      'assets/Logo/Plus Crown 1.png',
      height: MediaQuery.of(context).size.height * 0.07,
    ),
  );
}

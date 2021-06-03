import 'package:flutter/material.dart';

import '../../constants.dart';

class TitleHome extends StatelessWidget {
  final String title;

  const TitleHome({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: kPrimaryColor,
          fontFamily: 'GothamMedium',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

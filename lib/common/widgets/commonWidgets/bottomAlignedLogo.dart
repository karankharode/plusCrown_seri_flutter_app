import 'package:flutter/material.dart';

Align buildBottomAlignedLogo(BuildContext context) {
  return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        alignment: Alignment.bottomRight,
        width: MediaQuery.of(context).size.width / 1.4,
        child: Image.asset("assets/images/PlusCrown.png"),
      ));
}

import 'package:flutter/material.dart';
import 'package:seri_flutter_app/constants.dart';

InputDecoration getInputDecoration(String labelText) {
  return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 71, 54, 111),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
        gapPadding: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 71, 54, 111),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
        gapPadding: 10,
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 71, 54, 111),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
        gapPadding: 10,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: Color.fromARGB(255, 71, 54, 111),
        fontFamily: 'GothamMedium',
      ));
}

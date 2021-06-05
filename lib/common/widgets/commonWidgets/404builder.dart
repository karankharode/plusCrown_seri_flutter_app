import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget notFoundBuilder(containerHeight) {
  return Container(
    height: containerHeight,
    child: Center(
      child: Lottie.asset(
        'assets/animations/404Animation.json',
        width: double.infinity,
        height: 120,
        fit: BoxFit.scaleDown,
      ),
    ),
  );
}

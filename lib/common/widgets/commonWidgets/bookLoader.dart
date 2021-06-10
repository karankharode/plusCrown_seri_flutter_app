import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget bookLoader() {
  return Container(
    height: 650,
    child: Center(
      child: Lottie.asset(
        'assets/animations/loading.json',
        width: 220,
        height: 220,
        fit: BoxFit.fill,
      ),
    ),
  );
}

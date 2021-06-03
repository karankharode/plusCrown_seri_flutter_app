import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget bookLoader() {
  return Container(
    height: 600,
    child: Center(
      child: Lottie.asset(
        'assets/animations/loading.json',
        width: 180,
        height: 180,
        fit: BoxFit.fill,
      ),
    ),
  );
}

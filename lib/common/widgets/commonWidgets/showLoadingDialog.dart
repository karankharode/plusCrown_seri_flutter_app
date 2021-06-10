import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showLoadingDialog(context){
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [CircularProgressIndicator()],
            ),
          ),
        );
      });
}
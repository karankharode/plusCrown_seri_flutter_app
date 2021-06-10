import 'package:flutter/material.dart';

Container currentlyUnavailableBuilder() {
  return Container(
    //  width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.red[200].withOpacity(0.7),
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.all(Radius.circular(8))),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        "Currently  Unavailable",
        style: TextStyle(fontFamily: 'GothamMedium', fontSize: 14, color: Colors.red),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ListTile drawerTile(BuildContext context, title, Function navigatorfunction, destinationRoute) {
  return ListTile(
      dense: true,
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'GothamMedium',
            fontSize: 2.1.h,
            fontWeight: FontWeight.w500,
            color: Color(0xFF23124A)),
      ),
      onTap: () => navigatorfunction(context, destinationRoute));
}

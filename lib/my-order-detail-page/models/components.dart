import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Row buildOrderDetailsRow(String _title, double _cost) {
  return Row(children: [
    Text(
      _title,
      style: TextStyle(
        fontSize: 12.sp,
        color: Color.fromARGB(255, 71, 54, 111),
      ),
    ),
    Spacer(),
    Text(
      _cost == 0 ? 'Free' : 'Rs $_cost',
      style: TextStyle(
        fontSize: 12.sp,
        color: Color.fromARGB(255, 71, 54, 111),
      ),
    )
  ]);
}

Padding buildDeliveryDetailsCard(String _title, String _name, String _address, int _phone) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  _title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 71, 54, 111),
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              _name,
              style: TextStyle(
                fontSize: 8.sp,
                color: Color.fromARGB(255, 71, 54, 111),
              ),
            ),
            Text(
              _address,
              style: TextStyle(
                fontSize: 8.sp,
                color: Color.fromARGB(255, 71, 54, 111),
              ),
            ),
            Text(
              'Phone Number : $_phone',
              style: TextStyle(
                fontSize: 8.sp,
                color: Color.fromARGB(255, 71, 54, 111),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bookLoader.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

import '../models/components.dart';

class MyOrdersDetailPage extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const MyOrdersDetailPage({this.loginResponse, this.cartData});

  @override
  _MyOrdersDetailPageState createState() => _MyOrdersDetailPageState(loginResponse, cartData);
}

class _MyOrdersDetailPageState extends State<MyOrdersDetailPage> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _MyOrdersDetailPageState(this.loginResponse, this.cartData);

  Future futureForOrders;

  var cartController = CartController();

  @override
  void initState() {
    futureForOrders = cartController.getMyOrderDetails(GetMyOrderData(
      id: loginResponse.id,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTextAppBar(context, "Order", loginResponse, false, false, null),
      body: ListView(
        children: [
          
          Padding(
            padding: EdgeInsets.all(5.w),
            child: Text(
              'Order ID: 4863964',
              style: TextStyle(
                fontFamily: 'GothamMedium',
                fontSize: 14.sp,
                color: Color.fromARGB(255, 71, 54, 111),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
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
                          'Total Order Amount Rs. 2541',
                          style: TextStyle(
                            fontFamily: 'GothamMedium',
                            fontSize: 11.sp,
                            color: Color.fromARGB(255, 71, 54, 111),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '03 march 2022',
                          style: TextStyle(
                            fontFamily: 'GothamMedium',
                            fontSize: 9.sp,
                            color: Color.fromARGB(255, 71, 54, 111),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Paid on Cash on delivery',
                      style: TextStyle(
                        fontFamily: 'GothamMedium',
                        fontSize: 9.sp,
                        color: Color.fromARGB(255, 71, 54, 111),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Delivered',
                                      style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 71, 54, 111),
                                      ),
                                    ),
                                    Text(
                                      'on 8th march 2022',
                                      style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        fontSize: 9.sp,
                                        color: Color.fromARGB(255, 71, 54, 111),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(175, 71, 54, 111),
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(color: Colors.black12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Return/Exchange',
                                            style: TextStyle(
                                                fontFamily: 'GothamMedium',
                                                color: Colors.white,
                                                fontSize: 8.sp),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        'Download Invoice',
                                        style: TextStyle(
                                            fontFamily: 'GothamMedium',
                                            fontSize: 8.sp,
                                            color: Colors.green.shade900),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    constraints: BoxConstraints(maxHeight: 25.w),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/stationary/cello signature legacy ball pen.jpeg'),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rs. 599.00',
                                        style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(255, 71, 54, 111),
                                        ),
                                      ),
                                      Text(
                                        'Balbharti Textbook',
                                        style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          fontSize: 12.sp,
                                          color: Color.fromARGB(255, 71, 54, 111),
                                        ),
                                      ),
                                      Text(
                                        'English medium 8th Sanskrit',
                                        style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          fontSize: 9.sp,
                                          color: Color.fromARGB(255, 71, 54, 111),
                                        ),
                                      ),
                                      Text(
                                        'Return / Exchange window closed on Friday, 20th March, 2022',
                                        style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          fontSize: 9.sp,
                                          color: Color.fromARGB(255, 71, 54, 111),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      'Track Order',
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Return Complete',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'GothamMedium',
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 71, 54, 111),
                                      ),
                                    ),
                                    Text(
                                      'Return ID : RT7854',
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                        fontFamily: 'GothamMedium',
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      'Refund has been initiated on 13 March, 2022',
                                      style: TextStyle(
                                          fontSize: 8.sp,
                                          fontFamily: 'GothamMedium',
                                          color: Colors.green.shade900),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      'Total Refund Amount',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: 'GothamMedium',
                                          fontSize: 8.sp),
                                    ),
                                    Text(
                                      'Rs 1641.00',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontFamily: 'GothamMedium',
                                          fontSize: 8.sp),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    constraints: BoxConstraints(maxHeight: 25.w),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/stationary/cello signature legacy ball pen.jpeg'),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rs. 1641.00',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: 'GothamMedium',
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(255, 71, 54, 111),
                                        ),
                                      ),
                                      Text(
                                        'Balbharti Textbook',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                        ),
                                      ),
                                      Text(
                                        'English medium 8th Sanskrit',
                                        style: TextStyle(
                                          fontSize: 9.sp,
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                        ),
                                      ),
                                      Text(
                                        'Return / Exchange window closed on Friday, 20th March, 2022',
                                        style: TextStyle(
                                          fontSize: 9.sp,
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      'Track Order',
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color: Color.fromARGB(255, 71, 54, 111),
                                          fontSize: 8.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          buildDeliveryDetailsCard(
            'Return Pick up from',
            'Sapna',
            'PLot no. 101, Rohan Apt, Rotary Club, Near Datta Mandir, Ambernath (west)',
            8087976543,
          ),
          Padding(
            padding: EdgeInsets.all(5.w),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color.fromARGB(255, 71, 54, 111),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Details',
                      style: TextStyle(
                        fontFamily: 'GothamMedium',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 71, 54, 111),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    buildOrderDetailsRow('Card Total', 5297),
                    SizedBox(height: 1.h),
                    buildOrderDetailsRow('Card Savings', -1830),
                    SizedBox(height: 1.h),
                    buildOrderDetailsRow('Coupon Savings', -86),
                    SizedBox(height: 1.h),
                    buildOrderDetailsRow('Gift', 30),
                    SizedBox(height: 1.h),
                    buildOrderDetailsRow('Delivery', 0),
                    SizedBox(height: 1.h),
                    Row(children: [
                      Text(
                        'Card Total',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'GothamMedium',
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 71, 54, 111),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Rs 3438.00',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'GothamMedium',
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 71, 54, 111),
                        ),
                      )
                    ]),
                  ],
                ),
              ),
            ),
          ),
          buildDeliveryDetailsCard(
            'Delivered to',
            'Ohm Chadwick',
            'PLot no. 101, Rohan Apt, Rotary Club, Near Datta Mandir, Ambernath (west)',
            8087976543,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 5.w),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 71, 54, 111),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                  child: Text(
                    'Continue Shopping',
                    style: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

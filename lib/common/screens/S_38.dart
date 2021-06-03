import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Error404 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 6.w, top: 3.h, right: 6.w),
                width: MediaQuery.of(context).size.width * 0.88,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 71, 54, 111),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Error  404',
                        style: TextStyle(
                          fontFamily: 'GothamMedium',
                          fontSize: 32.0.sp,
                          letterSpacing: 0.5.w,
                          color: Color.fromARGB(255, 71, 54, 111),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Page not found',
                        style: TextStyle(
                          fontFamily: 'GothamMedium',
                          fontSize: 22.0.sp,
                          color: Color.fromARGB(255, 71, 54, 111),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3.w,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/10,),
                      MaterialButton(
                       // minWidth: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height/15,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => null));
                        },
                        color: Color.fromARGB(255, 71, 54, 111),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Continue Shopping",
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/50,),
                      Image(
                        width: MediaQuery.of(context).size.width * 0.8,
                       // height: MediaQuery.of(context).size.height * 0.8,
                        image: AssetImage('assets/images/fdnyt.png'),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

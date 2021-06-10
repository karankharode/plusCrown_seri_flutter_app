import 'package:flutter/material.dart';

Widget buildMockUserDetails(context) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    leading: CircleAvatar(
      backgroundImage: AssetImage(
        "assets/images/profile.png",
      ),
      radius: MediaQuery.of(context).size.width / 12,
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Your Name",
            style: TextStyle(
                color: Color.fromARGB(255, 71, 54, 111),
                fontFamily: 'GothamMedium',
                fontSize: MediaQuery.of(context).size.width / 16)),
        // GestureDetector(
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => Update(loginResponseForUserDetails, cartData)));
        //   },
        //   child: Text('Edit',
        //       style: TextStyle(
        //           fontFamily: 'GothamMedium',
        //           color: Color.fromARGB(255, 71, 54, 111),
        //           fontSize: MediaQuery.of(context).size.width / 23)),
        // ),
      ],
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8,
        ),
        Text("Email",
            style: TextStyle(
                color: Color.fromARGB(255, 71, 54, 111),
                fontFamily: 'GothamMedium',
                fontSize: MediaQuery.of(context).size.width / 23)),
        Text("Phone Number",
            style: TextStyle(
                color: Color.fromARGB(255, 71, 54, 111),
                fontFamily: 'GothamMedium',
                fontSize: MediaQuery.of(context).size.width / 23)),
      ],
    ),
  );
}

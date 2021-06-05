import 'package:flutter/material.dart';
import 'package:seri_flutter_app/common/screens/searchScreen/SearchScreen.dart';
import 'package:seri_flutter_app/common/services/routes/commonRouter.dart';
import 'package:seri_flutter_app/constants.dart';

SafeArea buildSearchBar(
    BuildContext context, Size size, Function crossAction, loginResponse, cartData) {
  TextEditingController _searchController = TextEditingController();
  return SafeArea(
    child: Container(
        height: 56, //size.height * 0.13,
        decoration: BoxDecoration(
          color: kPrimaryColor,
        ),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: 10,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 0.5,
          ),
          height: size.height * 0.044,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kPrimaryColor, width: 1),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: kDefaultPadding,
                ),
                child: Image.asset(
                  'assets/images/search.png',
                  width: size.width * 0.06,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  onEditingComplete: () {
                    Navigator.push(
                        context,
                        commonRouter(
                            SearchScreen(loginResponse, cartData, _searchController.text)));
                  },
                  decoration: InputDecoration(
                    // contentPadding:
                    //     EdgeInsets.only(top: kDefaultPadding * 0.05),
                    hintText: "SEARCH PRODUCTS",
                    hintStyle: TextStyle(
                      fontFamily: 'GothamMedium',
                      color: kPrimaryColor.withOpacity(0.5),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              GestureDetector(
                onTap: crossAction,
                child: Image.asset(
                  'assets/images/cross_purple.png',
                  width: size.width * 0.06,
                ),
              ),
            ],
          ),
        )),
  );
}

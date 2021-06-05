import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/common/widgets/appBars/appBar.dart';
import 'package:seri_flutter_app/homescreen/controller/categoryController.dart';
import 'package:seri_flutter_app/homescreen/models/category_class.dart';
import 'package:seri_flutter_app/homescreen/screens/body.dart';
import 'package:seri_flutter_app/login&signup/controller/login_controller.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../cart/models/CartData.dart';
import '../../constants.dart';

class HomePage extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const HomePage({this.loginResponse, this.cartData});

  @override
  _HomePageState createState() => _HomePageState(loginResponse, cartData);
}

class _HomePageState extends State<HomePage> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _HomePageState(this.loginResponse, this.cartData);

  var loginController = LoginController();
  LoginResponse loginResponseAfterDetails;
  getDetails() async {
    loginResponseAfterDetails = await loginController.getSavedUserDetails();
  }

  getCategoryData() async {
    List<CategoryData> fCategorydata = await CategoryController().getCategory();
    setState(() {
      globalCategoryData = fCategorydata;
    });
  }

  getGlobalCartData() async {
    CartData fcardData = await CartController().getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    setState(() {
      globalCartData = fcardData;
    });
  }

  getPermission() async {
    await [
      Permission.manageExternalStorage,
      Permission.storage,
    ].request();
  }

  @override
  void initState() {
    
    getCategoryData();
    getGlobalCartData();
    if (loginResponse == null) {
      getDetails();
    }
    getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loginController = Provider.of<LoginController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, loginResponse),
      drawer: CustomDrawer(loginResponse, cartData),
      //drawer: MyDrawer(),
      body: Body(loginResponse == null ? loginResponseAfterDetails : loginResponse, cartData),
    );
  }
}

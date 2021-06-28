import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/address/controller/AddressController.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/homescreen/screens/home_screen.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:seri_flutter_app/login&signup/screens/login.dart';
import 'package:seri_flutter_app/update_customer/controller/update_controller.dart';
import 'package:seri_flutter_app/update_customer/password/controller/password_controller.dart';
import 'package:sizer/sizer.dart';
import 'cart/controller/CartController.dart';
import 'cart/models/AddToCartData.dart';
import 'constants.dart';
import 'homescreen/controller/products_controller.dart';
import 'login&signup/controller/login_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: kPrimaryColor));

  final loginController = LoginController();

  var defaultPage;
  var cartController = CartController();

  bool isAuthorized = await loginController.isUserAuthorized();
  if (isAuthorized) {
    LoginResponse loginResponse = await loginController.getSavedUserDetails();
    CartData cartData = await cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    defaultPage = HomePage(
      loginResponse: loginResponse,
      cartData: cartData,
    );
  } else {
    defaultPage = LoginPage();
  }
  Widget defaultHome = defaultPage; // isAuthorized ? homePage : loginPage;
  var dir = await getApplicationDocumentsDirectory();
  Hive..init(dir.path);
  Hive.openBox('favBox');
  Hive.openBox('addedToCart');
  runApp(
    MultiProvider(
      providers: [
        Provider<LoginController>(create: (_) => LoginController()),
        Provider<UpdateController>(create: (_) => UpdateController()),
        Provider<PasswordController>(create: (_) => PasswordController()),
        Provider<CartController>(create: (_) => CartController()),
        Provider<AddressController>(create: (_) => AddressController()),
        Provider<ProductController>(create: (_) => ProductController()),

        // Provider<AnnouncementsController>(
        //     create: (_) => AnnouncementsController()),
        // Provider<CompetitionController>(create: (_) => CompetitionController()),
        // Provider<PaymentController>(create: (_) => PaymentController()),
        // Provider<RatingController>(create: (_) => RatingController())
      ],
      child: MyApp(startupPage: defaultHome),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startupPage;

  MyApp({this.startupPage});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          home: HomeScreen(startupPage: startupPage),
          // home: MyHomePage(startupPage: startupPage),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Widget startupPage;

  const HomeScreen({this.startupPage});

  @override
  Widget build(BuildContext context) {
    // return CheckOutPage();
    return startupPage;
  }
}

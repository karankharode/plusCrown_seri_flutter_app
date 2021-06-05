import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/widgets/appBars/textTitleAppBar.dart';
import 'package:seri_flutter_app/common/widgets/commonWidgets/bottomAlignedLogo.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

class FAQSection extends StatelessWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  FAQSection(this.loginResponse, this.cartData);

  MediaQueryData queryData;
  var cartController = CartController();

  List<Map> faqList = [
    {
      "ques": "What about the Refunds If the product is returned?",
      "ans":
          "You can shop easily by visiting our website, But we recommend creating an account on pluscrown. With minimum details required. You can keep the track of your wishlist, receive the daily updates, offers and discounts just for you.",
    },
    {
      "ques": "How do you pay at Pluscrown, Payment process in Pluscrown?",
      "ans":
          "There are many ways you can make payments and you can trust our payment gateways system. You can also opt. for cash on delivery methods, We also accept visa, debit and credit cards.",
    },
    {
      "ques": "What are the delivery charges?",
      "ans":
          "Delivery charges are the same for all products if you buy products worth Rs.300, You will not have to pay shipping charges and If you purchase the product less than 300rs then you have to pay a delivery fee of Rs.40.",
    },
    {
      "ques": "What is the estimated time of Arrival(ETA)?",
      "ans": "We will thrive to deliver your product within 2 working days.",
    },
    {
      "ques": "How you can track your orders and check the status?",
      "ans":
          "Once you login into your account, You can check the order you want to track and then select view order to see details after that click on track shipment.",
    },
    {
      "ques": "How can I Cancel my order?",
      "ans":
          "You can cancel your order within 48hrs after placing it. Go to my orders, select the product and click on cancel order option.",
    },
    {
      "ques": "If I receive a defective or wrong product, Then How do I return it?",
      "ans":
          "If you receive a defective or wrong product, You will have to go to your account and select the order you want to return and just click the return option, We will collect the product from you.",
    },
    {
      "ques": "How can I contact Pluscrown Customer Support?",
      "ans":
          "You can find our contact details on our Contact Us page, Along with the Customer Support no.",
    },
    {
      "ques": "Which products are not eligible for return policy?",
      "ans": "Products value ranging below Rs.100 are not eligible for Return",
    },
    {
      "ques": "How can I bulk order products for Corporate sectors?",
      "ans": "You can write to 'email to be inserted' for your Corporate order requirements.",
    },
    {
      "ques": "I missed the delivery of my order today. What should I do?",
      "ans":
          "Your order will be delivered within the next day of your current delivery date, before that we give a call to the customer and if you missed it we will contact you for the same.",
    },
    {
      "ques": "What should I do if my order is approved but hasn't been shipped yet?",
      "ans":
          "We send orders within 1-2 days before the delivery date so that they can reach you in time but if there is some problem delivering the products from our end we will inform you accordingly.  Even after that if you don’t receive the order then you can contact our Customer Support.",
    },
    {
      "ques": "How do I know my order has been confirmed?",
      "ans":
          "An confirmation email & SMS will be sent to your registered mobile no. once you've successfully placed your order. We'll also let you know as soon as we ship the product to you along with the tracking Id. You can track the order from My Orders tab.",
    },
    {
      "ques": "Why do I need to enter my pin code?",
      "ans":
          "By knowing your pincode, We can easily deliver products to your location, And you can find out whether particular product delivery is available at your location or not.",
    },
    {
      "ques": "What about the Refunds If the product is returned?",
      "ans":
          "You will receive the refund amount within 48hrs, As soon as we collect the product from you.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Scaffold(
      appBar: buildTextAppBar(context, "FAQ's", loginResponse, false, false, null),
      backgroundColor: Color.fromARGB(255, 249, 249, 249),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(
            5,
            10,
            10,
            5,
          ),
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              ...faqList.map((e) {
                return buildFAQExpansionTile(context, e['ques'], e['ans']);
              }).toList(),
              buildBottomAlignedLogo(context)
            ],
          ),
        ),
      ),
    );
  }

  Theme buildFAQExpansionTile(BuildContext context, ques, ans) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ExpansionTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '•',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 71, 54, 111),
                ),
              ),
              SizedBox(width: 5),
              Flexible(
                child: Text(
                  ques,
                  style: TextStyle(
                    fontFamily: 'GothamMedium',
                    fontSize: MediaQuery.of(context).size.width / 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF23124A),
                  ),
                ),
              ),
            ],
          ),
          childrenPadding: EdgeInsets.all(2),
          initiallyExpanded: false,
          backgroundColor: Colors.transparent,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 10, 0),
                  child: Image.asset(
                    'assets/icons/rightarrow.png',
                    height: queryData.size.height / 40,
                    width: queryData.size.width / 15,
                    color: Color.fromARGB(255, 71, 54, 111),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text(
                      ans,
                      style: TextStyle(
                        fontFamily: 'GothamMedium',
                        fontSize: MediaQuery.of(context).size.width / 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF23124A),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

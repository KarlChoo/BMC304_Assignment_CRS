import 'package:flutter/material.dart';
import 'package:bmc304_assignment_crs/constants.dart';
import 'package:bmc304_assignment_crs/screens/sign_in/sign_in_screen.dart';
import 'package:bmc304_assignment_crs/size_config.dart';

import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Crisis Relief Services (CRS) is an NGO that aims to help people who "
          "are facing crises arising from natural disasters",
      "subtitle": "Who are we?",
      "image": "assets/images/splash_1.png"
    },
    {
      "text": "We keep ourselves vigilant regarding disasters happening. \n We decide which of our volunteers"
      " is qualified for the job",
      "subtitle": "CRS Admin",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "Got the appropriate skills and time?\n "
          "Register now and lend us and the crisis victims a hand. We would appreciate it.",
      "subtitle": "Volunteer",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  subtitle: splashData[index]["subtitle"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: (20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Let's Go",
                      press: () {
                        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bmc304_assignment_crs/components/no_account_text.dart';
import 'package:bmc304_assignment_crs/components/socal_card.dart';
import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit close the application?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    Text(
                      "Welcome To CRS",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign in with your email and password ",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03),
                    SignForm(),
                    SizedBox(height: SizeConfig.screenHeight * 0.03),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     SocalCard(
                    //       icon: "assets/icons/google-icon.svg",
                    //       press: () {
                    //         print('Login with google');
                    //       },
                    //     ),
                    //     SocalCard(
                    //       icon: "assets/icons/facebook-2.svg",
                    //       press: () {
                    //         print('Login with facebook');
                    //       },
                    //     ),
                    //     SocalCard(
                    //       icon: "assets/icons/twitter.svg",
                    //       press: () {
                    //         print('Login with twitter');
                    //       },
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    NoAccountText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

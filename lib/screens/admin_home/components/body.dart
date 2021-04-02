import 'package:bmc304_assignment_crs/components/default_button.dart';
import 'package:bmc304_assignment_crs/providers/application_provider.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/screens/staff_edit_page/staff_edit_page.dart';
import 'package:bmc304_assignment_crs/screens/manager_home/components/staff_details.dart';
import 'package:bmc304_assignment_crs/screens/sign_in/sign_in_screen.dart';
import 'package:bmc304_assignment_crs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool needReloadData = true;

  @override
  void didChangeDependencies() async {
    if (needReloadData) {
      Provider.of<StaffProvider>(context).getAllSystemStaff().then((value) {
        needReloadData = false;
      });
    }
    super.didChangeDependencies();
    final applicationProvider = Provider.of<ApplicationProvider>(context);
    if (applicationProvider.applicationList.length == 0) {
      applicationProvider.getApplicationOfAdmin(Provider.of<StaffProvider>(context).currentStaff.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider>(context);
    Future<bool> _onWillPop() async {
      return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to logout'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                staffProvider.signoutStaff();
                Navigator.pushReplacementNamed(
                    context, SignInScreen.routeName);
              },
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: double.infinity,
                  height: getProportionateScreenHeight(250),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xfff37335), Color(0xfffDC830)],
                          stops: [0.4, 1])),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 58,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.black,
                            backgroundImage:
                            AssetImage("assets/images/profile-icon-png-910.png"),
                          ),
                        ),
                        Text(
                          "${staffProvider.currentStaff.firstName} ${staffProvider.currentStaff.lastName}",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        Text(
                          "${staffProvider.currentStaff.position}",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      StaffDetails(),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DefaultButton(
                              text: "Edit Profile",
                              press: () {
                                Navigator.pushNamed(
                                    context, StaffEditPage.routeName,
                                    arguments: staffProvider.currentStaff);
                              },
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(10),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              height: getProportionateScreenHeight(56),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: kPrimaryColor,
                                        width: getProportionateScreenWidth(2),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => new AlertDialog(
                                      title: new Text('Are you sure?'),
                                      content: new Text('Do you want to logout'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                            staffProvider.signoutStaff();
                                            Navigator.pushReplacementNamed(
                                                context, SignInScreen.routeName);
                                          },
                                          child: Text('Yes'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(18),
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: DefaultButton(
                          //     text: "Logout",
                          //     press: () {
                          //       showDialog(
                          //         context: context,
                          //         builder: (context) => new AlertDialog(
                          //           title: new Text('Are you sure?'),
                          //           content: new Text('Do you want to logout'),
                          //           actions: <Widget>[
                          //             TextButton(
                          //               onPressed: () =>
                          //                   Navigator.of(context).pop(false),
                          //               child: Text('No'),
                          //             ),
                          //             TextButton(
                          //               onPressed: () {
                          //                 Navigator.of(context).pop(true);
                          //                 staffProvider.signoutStaff();
                          //                 Navigator.pushReplacementNamed(
                          //                     context, SignInScreen.routeName);
                          //               },
                          //               child: Text('Yes'),
                          //             ),
                          //           ],
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

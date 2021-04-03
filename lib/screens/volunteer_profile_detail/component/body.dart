import 'package:bmc304_assignment_crs/components/default_button.dart';
import 'package:bmc304_assignment_crs/models/volunteer.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/screens/manager_home/components/staff_details.dart';
import 'package:bmc304_assignment_crs/screens/sign_in/sign_in_screen.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_profile_detail/component/volunteer_details.dart';
import 'package:bmc304_assignment_crs/size_config.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    Volunteer volunteer = ModalRoute.of(context).settings.arguments;
    return SafeArea(
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
                        "${volunteer.firstName} ${volunteer.lastName}",
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    VolunteerDetails(volunteer),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultButton(
                            text: "Go Back",
                            press: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

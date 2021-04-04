import 'package:bmc304_assignment_crs/components/default_button.dart';
import 'package:bmc304_assignment_crs/models/volunteer.dart';
import 'package:bmc304_assignment_crs/providers/application_provider.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/screens/manager_home/components/staff_details.dart';
import 'package:bmc304_assignment_crs/screens/sign_in/sign_in_screen.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_profile_detail/component/volunteer_details.dart';
import 'package:bmc304_assignment_crs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final kStaffLabelText = TextStyle(fontSize: 12, color: Colors.blueAccent);
  final kStaffDetailText = TextStyle(fontSize: 16);

  bool isInit = true;

  @override
  void didChangeDependencies() async{
    if(isInit){
      Volunteer volunteer = ModalRoute.of(context).settings.arguments;
      await Provider.of<ApplicationProvider>(context).getAllApplication(volunteer.id);
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Volunteer volunteer = ModalRoute.of(context).settings.arguments;
    var volunteerApplications = Provider.of<ApplicationProvider>(context).applicationList;

    int acceptedApplication() {
      int count = 0;
      volunteerApplications.forEach((application) {
        if(application.status == "Accepted") count++;
      });
      return count;
    }

    int rejectedApplication() {
      int count = 0;
      volunteerApplications.forEach((application) {
        if(application.status == "Rejected") count++;
      });
      return count;
    }

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
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email", style: kStaffLabelText),
                            Text(
                              volunteer.email,
                              style: kStaffDetailText,
                              overflow: TextOverflow.visible,
                            )
                          ],
                        ),
                        Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Phone", style: kStaffLabelText),
                            Text(
                              volunteer.phone,
                              style: kStaffDetailText,
                              overflow: TextOverflow.visible,
                            )
                          ],
                        ),
                        Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Address", style: kStaffLabelText),
                            Text(
                              volunteer.address,
                              style: kStaffDetailText,
                              overflow: TextOverflow.visible,
                            )
                          ],
                        ),
                        Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Number of applications made", style: kStaffLabelText),
                            Text(
                              volunteerApplications.length.toString(),
                              style: kStaffDetailText,
                              overflow: TextOverflow.visible,
                            )
                          ],
                        ),
                        Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Number of accepted/rejected applications", style: kStaffLabelText),
                            Row(
                              children: [
                                Text(
                                  acceptedApplication().toString(),
                                  style: TextStyle(fontSize: 16, color: Colors.green),
                                  overflow: TextOverflow.visible,
                                ),
                                Text(" / ", style: kStaffDetailText,),
                                Text(
                                  rejectedApplication().toString(),
                                  style: TextStyle(fontSize: 16, color: Colors.red),
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Divider(),
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

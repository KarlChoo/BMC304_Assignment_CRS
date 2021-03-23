import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:bmc304_assignment_crs/screens/profile_page/profile_screen.dart';
import 'package:bmc304_assignment_crs/screens/sign_in/sign_in_screen.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_application/volunteer_application_status_page.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_trips_application/trips_application_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Trip> tempList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    VolunteerProvider volunteerProvider =
        Provider.of<VolunteerProvider>(context);
    staffProvider.getAllTrips();
    tempList = staffProvider.staffsTrip;
    if (tempList.length > 0) {
      if (volunteerProvider.applicationList.length > 0) {
        for (int i = 0; i < volunteerProvider.applicationList.length; i++) {
          for (int j = 0; j < tempList.length; j++) {
            tempList.removeWhere((element) =>
                element.tripId == volunteerProvider.applicationList[i].tripId);
          }
        }
      } else {
        volunteerProvider
            .getAllApplication(volunteerProvider.currentVolunteer.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    VolunteerProvider volunteerProvider =
        Provider.of<VolunteerProvider>(context);
    volunteerProvider.clearApplicationList();
    if (volunteerProvider.applicationList.length == 0) {
      volunteerProvider
          .getAllApplication(volunteerProvider.currentVolunteer.id);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {Navigator.pushNamed(context, ProfilePage.routeName)},
          ),
          ProfileMenu(
            text: "Apply Trips",
            icon: "assets/icons/Bell.svg",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TripsApplication(
                            tempList: tempList,
                          )));
            },
          ),
          ProfileMenu(
            text: "Application Status",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.pushNamed(context, ApplicationStatus.routeName);
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              staffProvider.signoutStaff();
              volunteerProvider.signoutVolunteer();
              Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName,
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}

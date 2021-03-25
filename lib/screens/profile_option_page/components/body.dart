import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:bmc304_assignment_crs/providers/application_provider.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/providers/trip_provider.dart';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:bmc304_assignment_crs/screens/profile_page/profile_screen.dart';
import 'package:bmc304_assignment_crs/screens/sign_in/sign_in_screen.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_application/all_application_page.dart';
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
  void didChangeDependencies() async {
    super.didChangeDependencies();
    TripProvider tripProvider = Provider.of<TripProvider>(context);
    ApplicationProvider applicationProvider =
        Provider.of<ApplicationProvider>(context);
    await tripProvider.getAllTrips();
    if (tripProvider.staffsTrip.length > 0) {
      for (int i = 0; i < applicationProvider.applicationList.length; i++) {
        tripProvider.staffsTrip.removeWhere((element) =>
            element.tripId == applicationProvider.applicationList[i].tripId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    ApplicationProvider applicationProvider =
        Provider.of<ApplicationProvider>(context);
    VolunteerProvider volunteerProvider =
        Provider.of<VolunteerProvider>(context);
    TripProvider tripProvider = Provider.of<TripProvider>(context);

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
                            tempList: tripProvider.staffsTrip,
                          )));
            },
          ),
          ProfileMenu(
            text: "Application Status",
            icon: "assets/icons/Settings.svg",
            press: () async {
              Navigator.pushNamed(context, ApplicationStatus.routeName);
            },
          ),
          ProfileMenu(
            text: "All Application",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.pushNamed(context, AllApplication.routeName);
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              staffProvider.signoutStaff();
              volunteerProvider.signoutVolunteer();
              applicationProvider.clearApplicationList();
              Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName,
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/screens/admin_home/admin_home.dart';
import 'package:bmc304_assignment_crs/screens/admin_organize_trips/admin_organize_trips.dart';
import 'package:bmc304_assignment_crs/screens/manager_home/manager_home.dart';
import 'package:bmc304_assignment_crs/screens/profile_option_page/profile_screen.dart';
import 'package:bmc304_assignment_crs/screens/trip_report/trip_report.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_report/volunteer_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../enums.dart';

class AdminBottomNav extends StatelessWidget {
  const AdminBottomNav({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final AdminMenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    final staffProvider = Provider.of<StaffProvider>(context);

    buildNavButtons() {
      List<SizedBox> navButtonsList = [];
      SizedBox adminHomeBtn = SizedBox.fromSize(
        size: Size(54, 54),
        child: GestureDetector(
          onTap: () {
            if (this.selectedMenu != AdminMenuState.home)
              Navigator.pushReplacementNamed(context, AdminHome.routeName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home_outlined,
                size: 28,
                color: AdminMenuState.home == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              Text(
                "Home",
                style: TextStyle(
                    color: AdminMenuState.home == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                    fontSize: 11),
              )
            ],
          ),
        ),
      );
      /*SizedBox manageApplicationBtn = SizedBox.fromSize(
        size: Size(54, 54),
        child: GestureDetector(
          onTap: () {
            if (this.selectedMenu != AdminMenuState.manage_application)
              //Navigator.pushNamedAndRemoveUntil(context, ManagerManageAdmin.routeName, ModalRoute.withName('/sign_in'));
              Navigator.pushReplacementNamed(
                  context, AdminManageApplication.routeName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/staff_card.svg",
                width: 24,
                color: AdminMenuState.manage_application == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              Text(
                "Admin",
                style: TextStyle(
                    color: AdminMenuState.manage_application == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                    fontSize: 11),
              )
            ],
          ),
        ),
      );
      */
      SizedBox organizeTripBtn = SizedBox.fromSize(
        size: Size(54, 54),
        child: GestureDetector(
          onTap: () {
            if (this.selectedMenu != AdminMenuState.organize_trips)
              Navigator.pushReplacementNamed(
                  context, AdminOrganizeTrip.routeName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.flight_takeoff_outlined,
                size: 28,
                color: AdminMenuState.organize_trips == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              Text(
                "Trip",
                style: TextStyle(
                    color: AdminMenuState.organize_trips == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                    fontSize: 11),
              )
            ],
          ),
        ),
      );


      navButtonsList.add(adminHomeBtn);
      //navButtonsList.add(manageApplicationBtn);
      navButtonsList.add(organizeTripBtn);

      return navButtonsList;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buildNavButtons(),
          )),
    );
  }
}
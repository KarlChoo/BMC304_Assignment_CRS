import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/screens/manager_home/manager_home.dart';
import 'package:bmc304_assignment_crs/screens/profile_option_page/profile_screen.dart';
import 'package:bmc304_assignment_crs/screens/manager_manage_admin/manager_manage_admin.dart';
import 'package:bmc304_assignment_crs/screens/manager_manage_staffs/manager_manage_staffs.dart';
import 'package:bmc304_assignment_crs/screens/trip_report/trip_report.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_report/volunteer_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../enums.dart';

class StaffBottomNav extends StatelessWidget {
  const StaffBottomNav({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final StaffMenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    final staffProvider = Provider.of<StaffProvider>(context);

    buildNavButtons() {
      List<SizedBox> navButtonsList = [];
      SizedBox managerHomeBtn = SizedBox.fromSize(
        size: Size(54, 54),
        child: GestureDetector(
          onTap: () {
            if (this.selectedMenu != StaffMenuState.home)
              Navigator.pushReplacementNamed(context, ManagerHome.routeName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home_outlined,
                size: 28,
                color: StaffMenuState.home == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              Text(
                "Home",
                style: TextStyle(
                    color: StaffMenuState.home == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                    fontSize: 11),
              )
            ],
          ),
        ),
      );
      SizedBox adminManageBtn = SizedBox.fromSize(
        size: Size(54, 54),
        child: GestureDetector(
          onTap: () {
            if (this.selectedMenu != StaffMenuState.admin)
              //Navigator.pushNamedAndRemoveUntil(context, ManagerManageAdmin.routeName, ModalRoute.withName('/sign_in'));
              Navigator.pushReplacementNamed(
                  context, ManagerManageAdmin.routeName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/staff_card.svg",
                width: 24,
                color: StaffMenuState.admin == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              Text(
                "Admin",
                style: TextStyle(
                    color: StaffMenuState.admin == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                    fontSize: 11),
              )
            ],
          ),
        ),
      );
      SizedBox managerManageBtn = SizedBox.fromSize(
        size: Size(54, 54),
        child: GestureDetector(
          onTap: () {
            if (this.selectedMenu != StaffMenuState.staff)
              Navigator.pushReplacementNamed(
                  context, ManagerManageStaff.routeName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   "assets/icons/Star Icon.svg",
              //   width: 24,
              //   color: StaffMenuState.staff == selectedMenu
              //       ? kPrimaryColor
              //       : inActiveIconColor,
              // ),
              Icon(
                Icons.handyman,
                size: 28,
                color: StaffMenuState.staff == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              Text(
                "Manager",
                style: TextStyle(
                    color: StaffMenuState.staff == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                    fontSize: 11),
              )
            ],
          ),
        ),
      );
      SizedBox tripReportBtn = SizedBox.fromSize(
        size: Size(54, 54),
        child: GestureDetector(
          onTap: () {
            if (this.selectedMenu != StaffMenuState.trip_report)
              Navigator.pushReplacementNamed(context, TripReport.routeName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/report.svg",
                width: 24,
                color: StaffMenuState.trip_report == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              Text(
                "Trip",
                style: TextStyle(
                    color: StaffMenuState.trip_report == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                    fontSize: 11),
              )
            ],
          ),
        ),
      );
      SizedBox volunteerReportBtn = SizedBox.fromSize(
        size: Size(54, 54),
        child: GestureDetector(
          onTap: () {
            if (this.selectedMenu != StaffMenuState.volunteer_report)
              Navigator.pushReplacementNamed(
                  context, VolunteerReport.routeName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/Heart Icon_2.svg",
                width: 24,
                color: StaffMenuState.volunteer_report == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              Text(
                "Volunteer",
                style: TextStyle(
                    color: StaffMenuState.volunteer_report == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                    fontSize: 11),
              )
            ],
          ),
        ),
      );

      navButtonsList.add(managerHomeBtn);
      navButtonsList.add(adminManageBtn);
      if (staffProvider.currentStaff.position == "Director")
        navButtonsList.add(managerManageBtn);
      navButtonsList.add(tripReportBtn);
      navButtonsList.add(volunteerReportBtn);

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

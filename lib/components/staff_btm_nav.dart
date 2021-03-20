import 'package:bmc304_assignment_crs/screens/profile/profile_screen.dart';
import 'package:bmc304_assignment_crs/screens/staff_home/staff_home.dart';
import 'package:bmc304_assignment_crs/screens/staff_manage_admin/staff_manage_admin.dart';
import 'package:bmc304_assignment_crs/screens/staff_manage_staffs/staff_manage_managers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            children: [
              SizedBox.fromSize(
                size: Size(54, 54),
                child: GestureDetector(
                  onTap: () {
                    if(this.selectedMenu != StaffMenuState.home)
                      Navigator.pushReplacementNamed(context, StaffHome.routeName);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Shop Icon.svg",
                        color: StaffMenuState.home == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      Text("Home",
                        style: TextStyle(
                          color: StaffMenuState.home == selectedMenu
                              ? kPrimaryColor
                              : inActiveIconColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox.fromSize(
                size: Size(54, 54),
                child: GestureDetector(
                  onTap: () {
                    if(this.selectedMenu != StaffMenuState.admin)
                      Navigator.pushNamedAndRemoveUntil(context, StaffManageAdmin.routeName, ModalRoute.withName('/sign_in'));
                      //Navigator.pushReplacementNamed(context, StaffManageAdmin.routeName);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/staff_card.svg",
                        color: StaffMenuState.admin == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      Text("Admin",
                        style: TextStyle(
                          color: StaffMenuState.admin == selectedMenu
                              ? kPrimaryColor
                              : inActiveIconColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox.fromSize(
                size: Size(54, 54),
                child: GestureDetector(
                  onTap: () {
                    if(this.selectedMenu != StaffMenuState.staff)
                      Navigator.pushNamedAndRemoveUntil(context, StaffManageManagers.routeName, ModalRoute.withName('/sign_in'));
                      //Navigator.pushReplacementNamed(context,  StaffManageStaffs.routeName);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Chat bubble Icon.svg",
                        color: StaffMenuState.staff == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      Text("Staffs",
                        style: TextStyle(
                          color: StaffMenuState.staff == selectedMenu
                              ? kPrimaryColor
                              : inActiveIconColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // SizedBox.fromSize(
              //   size: Size(54, 54),
              //   child: GestureDetector(
              //     onTap: () {
              //       if(this.selectedMenu != StaffMenuState.trip_report)
              //         Navigator.pushReplacementNamed(context, StaffManageStaffs.routeName);
              //     },
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         SvgPicture.asset(
              //           "assets/icons/receipt.svg",
              //           color: StaffMenuState.trip_report == selectedMenu
              //               ? kPrimaryColor
              //               : inActiveIconColor,
              //         ),
              //         Text("Trip report",
              //           style: TextStyle(
              //             color: StaffMenuState.trip_report == selectedMenu
              //                 ? kPrimaryColor
              //                 : inActiveIconColor,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // IconButton(
              //   icon: SvgPicture.asset(
              //     "assets/icons/Shop Icon.svg",
              //     color: StaffMenuState.home == selectedMenu
              //         ? kPrimaryColor
              //         : inActiveIconColor,
              //   ),
              //   onPressed: () {
              //     if(this.selectedMenu != StaffMenuState.home)
              //       Navigator.pushReplacementNamed(context, StaffHome.routeName);
              //   },
              //   padding: EdgeInsets.zero,
              // ),
              // IconButton(
              //   icon: SvgPicture.asset("assets/icons/staff_card.svg",
              //     color: StaffMenuState.admin == selectedMenu
              //     ? kPrimaryColor
              //         : inActiveIconColor,
              //   ),
              //   onPressed: () {
              //     if(this.selectedMenu != StaffMenuState.admin)
              //       Navigator.pushNamed(context, StaffManageAdmin.routeName);
              //   },
              // ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: StaffMenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  // Navigator.pushNamedAndRemoveUntil(context,
                  //     ProfileScreen.routeName, (Route<dynamic> route) => false);
                  Navigator.pushNamed(context, ProfileScreen.routeName);
                },
              ),
            ],
          )),
    );
  }
}

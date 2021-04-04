import 'package:bmc304_assignment_crs/providers/application_provider.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:bmc304_assignment_crs/screens/sign_in/sign_in_screen.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    ApplicationProvider applicationProvider =
        Provider.of<ApplicationProvider>(context);
    VolunteerProvider volunteerProvider =
        Provider.of<VolunteerProvider>(context);
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            )),
        child: SafeArea(
            top: false,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: MenuState.home == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                      size: 30,
                    ),
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, HomeScreen.routeName),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: MenuState.profile == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                        size: 30,
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
                                          volunteerProvider.signoutVolunteer();
                                          applicationProvider
                                              .clearApplicationList();
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              SignInScreen.routeName,
                                              (Route<dynamic> route) => false);
                                        },
                                        child: Text('Yes'),
                                      )
                                    ]));
                      })
                ])));
  }
}

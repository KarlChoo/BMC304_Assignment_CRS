import 'package:bmc304_assignment_crs/screens/manager_home/components/body.dart';
import 'package:flutter/material.dart';
import '../../enums.dart';
import '../../components/staff_btm_nav.dart';

class ManagerHome extends StatelessWidget {
  static String routeName = "/manager_home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: StaffBottomNav(selectedMenu: StaffMenuState.home,),
    );
  }
}
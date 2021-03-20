import 'package:bmc304_assignment_crs/components/custom_bottom_nav_bar.dart';
import 'package:bmc304_assignment_crs/screens/staff_home/components/body.dart';
import 'package:flutter/material.dart';
import '../../enums.dart';
import '../../size_config.dart';
import '../../components/staff_btm_nav.dart';

class StaffHome extends StatelessWidget {
  static String routeName = "/staff_home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: StaffBottomNav(selectedMenu: StaffMenuState.home,),
    );
  }
}
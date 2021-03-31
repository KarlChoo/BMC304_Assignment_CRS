import 'package:bmc304_assignment_crs/components/admin_btm_nav.dart';
import 'package:bmc304_assignment_crs/screens/admin_home/components/body.dart';
import 'package:flutter/material.dart';
import '../../enums.dart';
import '../../components/staff_btm_nav.dart';

class AdminHome extends StatelessWidget {
  static String routeName = "/admin_home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: AdminBottomNav(
        selectedMenu: AdminMenuState.home,
      ),
    );
  }
}

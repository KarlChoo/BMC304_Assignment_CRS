import 'package:flutter/material.dart';
import 'package:bmc304_assignment_crs/components/user_refresh_btn.dart';
import 'package:bmc304_assignment_crs/components/admin_btm_nav.dart';
import 'package:bmc304_assignment_crs/screens/admin_manage_applications/components/body.dart';


import '../../enums.dart';

class AdminManageApplications extends StatelessWidget {
  static String routeName = "/admin_manage_applications";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application List Page"),
      ),
      body: Body(),
      bottomNavigationBar: AdminBottomNav(
        selectedMenu: AdminMenuState.manage_application,
      ),
    );
  }
}
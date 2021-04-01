import 'package:flutter/material.dart';
import 'package:bmc304_assignment_crs/components/user_refresh_btn.dart';
import 'package:bmc304_assignment_crs/components/admin_btm_nav.dart';
import 'package:bmc304_assignment_crs/screens/admin_organize_trips/components/body.dart';

import 'components/register_floating_button.dart';

import '../../enums.dart';

class AdminOrganizeTrip extends StatelessWidget {
  static String routeName = "/admin_organize_trips";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip List Page"),
      ),
      body: Body(),
      bottomNavigationBar: AdminBottomNav(
        selectedMenu: AdminMenuState.organize_trips,
      ),
      floatingActionButton: RegisterFloatingButton(),
    );
  }
}
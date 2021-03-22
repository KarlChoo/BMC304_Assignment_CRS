import 'package:bmc304_assignment_crs/components/staff_btm_nav.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_report/component/body.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class VolunteerReport extends StatelessWidget {
  static String routeName = "/volunteer_report";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Volunteer report"),
      ),
      body: Body(),
      bottomNavigationBar: StaffBottomNav(
        selectedMenu: StaffMenuState.volunteer_report,
      ),
    );
  }
}

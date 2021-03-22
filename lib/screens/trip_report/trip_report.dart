import 'package:bmc304_assignment_crs/components/staff_btm_nav.dart';
import 'package:bmc304_assignment_crs/screens/trip_report/component/body.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class TripReport extends StatelessWidget {
  static String routeName = "/trip_report";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip report"),
      ),
      body: Body(),
      bottomNavigationBar: StaffBottomNav(
        selectedMenu: StaffMenuState.trip_report,
      ),
    );
  }
}

import 'package:bmc304_assignment_crs/screens/admin_add_trip/components/body.dart';
import 'package:flutter/material.dart';

class AdminAddTrip extends StatelessWidget {
  static String routeName = "/admin_add_trip";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Trip"),
      ),
      body: Body(),
    );
  }
}

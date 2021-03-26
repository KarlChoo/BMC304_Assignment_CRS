import 'package:bmc304_assignment_crs/models/staff.dart';
import 'package:bmc304_assignment_crs/screens/staff_edit_page/components/body.dart';
import 'package:flutter/material.dart';

class StaffEditPage extends StatelessWidget {
  static String routeName = "/staff_edit_page";

  @override
  Widget build(BuildContext context) {
    Staff staff = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${staff.position} Details"),
      ),
      body: Body(),
    );
  }
}

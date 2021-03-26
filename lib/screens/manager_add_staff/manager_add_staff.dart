import 'package:bmc304_assignment_crs/screens/manager_add_staff/components/body.dart';
import 'package:flutter/material.dart';

class ManagerAddStaff extends StatelessWidget {
  static String routeName = "/manager_add_admin";

  @override
  Widget build(BuildContext context) {
    final staffPosition = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Register New $staffPosition"),
      ),
      body: Body(),
    );
  }
}

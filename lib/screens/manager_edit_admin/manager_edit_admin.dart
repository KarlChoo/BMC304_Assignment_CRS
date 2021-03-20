import 'package:bmc304_assignment_crs/screens/manager_edit_admin/components/body.dart';
import 'package:flutter/material.dart';

class ManagerEditAdmin extends StatelessWidget {
  static String routeName = "/manager_edit_admin";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Admin Details"),
      ),
      body: Body(),
    );
  }
}
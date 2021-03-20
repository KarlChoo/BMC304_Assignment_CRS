import 'package:bmc304_assignment_crs/screens/manager_add_admin/components/body.dart';
import 'package:flutter/material.dart';

class ManagerAddAdmin extends StatelessWidget {
  static String routeName = "/manager_add_admin";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register New Admin"),
      ),
      body: Body(),
    );
  }
}
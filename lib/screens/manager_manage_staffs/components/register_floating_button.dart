import 'package:bmc304_assignment_crs/screens/manager_add_staff/manager_add_staff.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class RegisterFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.add,
        size: 28,
      ),
      backgroundColor: kPrimaryColor,
      onPressed: () {
        Navigator.pushNamed(context, ManagerAddStaff.routeName,
            arguments: "Manager");
      },
    );
  }
}

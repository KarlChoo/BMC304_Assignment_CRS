import 'package:bmc304_assignment_crs/screens/manager_add_admin/manager_add_admin.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class RegisterFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add,size: 28,),
      backgroundColor: kPrimaryColor,
      onPressed: () {
        Navigator.pushNamed(context, ManagerAddAdmin.routeName);
      },
    );
  }
}

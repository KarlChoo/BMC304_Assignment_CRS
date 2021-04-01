import 'package:bmc304_assignment_crs/screens/admin_add_trip/admin_add_trip.dart';
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
        Navigator.pushNamed(context, AdminAddTrip.routeName,
            arguments: "Admin");
      },
    );
  }
}

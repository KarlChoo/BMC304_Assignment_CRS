import 'package:bmc304_assignment_crs/screens/staff_home/components/body.dart';
import 'package:flutter/material.dart';
import '../../size_config.dart';

class StaffHome extends StatelessWidget {
  static String routeName = "/staff_home";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
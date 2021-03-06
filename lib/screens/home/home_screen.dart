import 'package:flutter/material.dart';
import 'package:bmc304_assignment_crs/components/custom_bottom_nav_bar.dart';
import 'package:bmc304_assignment_crs/enums.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);

    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}

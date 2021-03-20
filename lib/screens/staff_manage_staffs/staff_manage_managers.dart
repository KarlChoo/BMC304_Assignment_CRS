import 'package:flutter/material.dart';

import 'package:bmc304_assignment_crs/components/staff_btm_nav.dart';
import 'package:bmc304_assignment_crs/screens/staff_manage_staffs/components/body.dart';

import '../../enums.dart';

class StaffManageManagers extends StatelessWidget {
  static String routeName = "/staff_manage_manager";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Manager"),
      ),
      body: Body(),
      bottomNavigationBar: StaffBottomNav(selectedMenu: StaffMenuState.staff,),
    );
  }
}
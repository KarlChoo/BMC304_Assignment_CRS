import 'package:bmc304_assignment_crs/components/staff_btm_nav.dart';
import 'package:bmc304_assignment_crs/constants.dart';
import 'package:bmc304_assignment_crs/screens/manager_manage_admin/component/body.dart';
import 'package:flutter/material.dart';
import 'component/register_floating_button.dart';

import '../../enums.dart';

class ManagerManageAdmin extends StatelessWidget {
  static String routeName = "/manager_manage_admin";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin manager"),
      ),
      body: Body(),
      bottomNavigationBar: StaffBottomNav(selectedMenu: StaffMenuState.admin,),
      floatingActionButton: RegisterFloatingButton()
    );
  }
}
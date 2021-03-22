import 'package:flutter/material.dart';
import 'package:bmc304_assignment_crs/components/user_refresh_btn.dart';
import 'package:bmc304_assignment_crs/components/staff_btm_nav.dart';
import 'package:bmc304_assignment_crs/screens/manager_manage_staffs/components/body.dart';

import 'components/register_floating_button.dart';

import '../../enums.dart';

class ManagerManageStaff extends StatelessWidget {
  static String routeName = "/staff_manage_manager";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manager List Page"),
        actions: [UserRefreshButton()],
      ),
      body: Body(),
      bottomNavigationBar: StaffBottomNav(
        selectedMenu: StaffMenuState.staff,
      ),
      floatingActionButton: RegisterFloatingButton(),
    );
  }
}

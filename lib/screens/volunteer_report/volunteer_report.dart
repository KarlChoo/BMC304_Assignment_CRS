import 'package:bmc304_assignment_crs/components/staff_btm_nav.dart';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_report/component/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enums.dart';

class VolunteerReport extends StatelessWidget {
  static String routeName = "/volunteer_report";

  @override
  Widget build(BuildContext context) {
    final volunteerProvider = Provider.of<VolunteerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Volunteer report"),
        actions: [
            IconButton(
              icon: Icon(Icons.refresh,color: Colors.white,size: 30,),
              onPressed: () async{
                await volunteerProvider.getAllVolunteers();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Volunteer data has been refreshed",
                      ),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: "Ok",
                        onPressed: () {  },
                      ),
                      behavior: SnackBarBehavior.fixed,
                    )
                );
              }
          )
        ],
      ),
      body: Body(),
      bottomNavigationBar: StaffBottomNav(
        selectedMenu: StaffMenuState.volunteer_report,
      ),
    );
  }
}

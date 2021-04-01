import 'package:bmc304_assignment_crs/providers/application_provider.dart';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:flutter/material.dart';
import 'package:bmc304_assignment_crs/components/custom_bottom_nav_bar.dart';
import 'package:bmc304_assignment_crs/enums.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() async {
    VolunteerProvider volunteerProvider =
        Provider.of<VolunteerProvider>(context);
    ApplicationProvider applicationProvider =
        Provider.of<ApplicationProvider>(context);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (applicationProvider.applicationList.length == 0) {
      await applicationProvider
          .getAllApplication(volunteerProvider.currentVolunteer.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}

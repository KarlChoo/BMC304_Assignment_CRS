import 'package:bmc304_assignment_crs/providers/application_provider.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/providers/trip_provider.dart';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:bmc304_assignment_crs/screens/admin_home/admin_home.dart';
import 'package:bmc304_assignment_crs/screens/manager_home/manager_home.dart';
import 'package:flutter/material.dart';
import 'package:bmc304_assignment_crs/components/default_button.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_home/home_screen.dart';
import 'package:bmc304_assignment_crs/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);
    final applicationProvider = Provider.of<ApplicationProvider>(context);
    final staffProvider = Provider.of<StaffProvider>(context);
    final volunteerProvider = Provider.of<VolunteerProvider>(context);

    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit close the application?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: IntrinsicWidth(
        stepWidth: double.infinity,
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.04),
            Image.asset(
              "assets/images/success.png",
              height: SizeConfig.screenHeight * 0.4, //40%
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.08),
            Text(
              "Login Success",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: DefaultButton(
                text: "Go to Dashboard",
                press: () async {
                  //Navigator.pushNamed(context, HomeScreen.routeName);
                  if (staffProvider.currentStaff != null) {

                    if (staffProvider.currentStaff.position=='Admin'){

                      print('test');
                      Navigator.pushReplacementNamed(
                          context, AdminHome.routeName);
                    }
                    else{
                      Navigator.pushReplacementNamed(
                          context, ManagerHome.routeName);
                    }

                  } else if (volunteerProvider.currentVolunteer != null) {
                    Navigator.pushReplacementNamed(
                        context, HomeScreen.routeName);
                  }
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:bmc304_assignment_crs/screens/staff_home/staff_home.dart';
import 'package:flutter/material.dart';
import 'package:bmc304_assignment_crs/components/default_button.dart';
import 'package:bmc304_assignment_crs/screens/home/home_screen.dart';
import 'package:bmc304_assignment_crs/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    VolunteerProvider volunteerProvider = Provider.of<VolunteerProvider>(context);
    return Center(
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
              press: () {
                //Navigator.pushNamed(context, HomeScreen.routeName);
                if(staffProvider.currentStaff != null){
                  Navigator.pushReplacementNamed(context, StaffHome.routeName);
                }else if(volunteerProvider.currentVolunteer != null){
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                }
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

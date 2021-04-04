import 'package:bmc304_assignment_crs/models/volunteer.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_profile_detail/volunteer_profile_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class VolunteerListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final volunteerProvider = Provider.of<StaffProvider>(context);
    final volunteer = Provider.of<Volunteer>(context);
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 2.0,
      child: InkWell(
        onTap: () {
            Navigator.pushNamed(context, VolunteerDetail.routeName, arguments: volunteer);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    backgroundImage: AssetImage("assets/images/profile-icon-png-910.png"),
                  ),
                  SizedBox(width: getProportionateScreenWidth(10),),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "${volunteer.firstName} ${volunteer.lastName}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.person,color: Colors.grey,size: 14,),
                  SizedBox(width: getProportionateScreenWidth(5),),
                  Expanded(
                    flex: 1,
                    child: Text(volunteer.username,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.phone,color: Colors.grey,size: 14),
                  SizedBox(width: getProportionateScreenWidth(5),),
                  Expanded(
                    child: Text(volunteer.phone,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.email,color: Colors.grey,size: 14,),
                  SizedBox(width: getProportionateScreenWidth(5),),
                  Expanded(
                    child: Text(volunteer.email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

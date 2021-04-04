import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:bmc304_assignment_crs/models/volunteer.dart';
import 'package:bmc304_assignment_crs/providers/application_provider.dart';
import 'package:bmc304_assignment_crs/providers/trip_provider.dart';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class VolunteerDetails extends StatefulWidget {
  final Volunteer volunteer;
  VolunteerDetails(this.volunteer);
  @override
  _VolunteerDetailsState createState() => _VolunteerDetailsState();
}

class _VolunteerDetailsState extends State<VolunteerDetails> {
  final kStaffLabelText = TextStyle(fontSize: 12, color: Colors.blueAccent);
  final kStaffDetailText = TextStyle(fontSize: 16);

  bool isInit = true;

  @override
  void didChangeDependencies() async{
    if(isInit){
      final volunteer = widget.volunteer;
      await Provider.of<ApplicationProvider>(context).getAllApplication(volunteer.id);
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var volunteerApplications = Provider.of<ApplicationProvider>(context).applicationList;

    int acceptedApplication() {
      int count = 0;
      volunteerApplications.forEach((application) {
        if(application.status == "Accepted") count++;
      });
      return count;
    }

    int rejectedApplication() {
      int count = 0;
      volunteerApplications.forEach((application) {
        if(application.status == "Rejected") count++;
      });
      return count;
    }

    return ListView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email", style: kStaffLabelText),
            Text(
              widget.volunteer.email,
              style: kStaffDetailText,
              overflow: TextOverflow.visible,
            )
          ],
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Phone", style: kStaffLabelText),
            Text(
              widget.volunteer.phone,
              style: kStaffDetailText,
              overflow: TextOverflow.visible,
            )
          ],
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Address", style: kStaffLabelText),
            Text(
              widget.volunteer.address,
              style: kStaffDetailText,
              overflow: TextOverflow.visible,
            )
          ],
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Number of applications made", style: kStaffLabelText),
            Text(
              volunteerApplications.length.toString(),
              style: kStaffDetailText,
              overflow: TextOverflow.visible,
            )
          ],
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Number of accepted/rejected applications", style: kStaffLabelText),
            Row(
              children: [
                Text(
                  acceptedApplication().toString(),
                  style: TextStyle(fontSize: 16, color: Colors.green),
                  overflow: TextOverflow.visible,
                ),
                Text(" / ", style: kStaffDetailText,),
                Text(
                  rejectedApplication().toString(),
                  style: TextStyle(fontSize: 16, color: Colors.red),
                  overflow: TextOverflow.visible,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

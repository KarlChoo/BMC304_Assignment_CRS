import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:bmc304_assignment_crs/models/volunteer.dart';
import 'package:bmc304_assignment_crs/providers/trip_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    int tripsAttended(){
      int count = 0;
      widget.volunteer.applicationList.forEach((application) {
        Trip trip = Provider.of<TripProvider>(context).getTrip(application.tripId);
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
             "${widget.volunteer.applicationsCreated().toString()} | "
               "${widget.volunteer.applicationsAccepted().toString()} | "
               "${widget.volunteer.applicationsRejected().toString()} ",
              style: kStaffDetailText,
              overflow: TextOverflow.visible,
            )
          ],
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Number of trips attended", style: kStaffLabelText),
            Text(
              tripsAttended().toString(),
              style: kStaffDetailText,
              overflow: TextOverflow.visible,
            )
          ],
        ),
      ],
    );
  }
}

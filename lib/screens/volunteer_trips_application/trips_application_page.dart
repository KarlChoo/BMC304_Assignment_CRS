import 'package:bmc304_assignment_crs/models/application.dart';
import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:bmc304_assignment_crs/providers/application_provider.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/providers/trip_provider.dart';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripsApplication extends StatefulWidget {
  static const routeName = '/Trips_application';
  final List<Trip> tempList;

  TripsApplication({this.tempList});
  @override
  _TripsApplicationState createState() => _TripsApplicationState();
}

class _TripsApplicationState extends State<TripsApplication> {
  bool isEnabled = true;
  int index2;
  List<Trip> tempList = [];
  crisisIcons(String type) {
    if (type == 'Flood') {
      return CircleAvatar(
        backgroundImage: AssetImage('assets/images/flood.png'),
      );
    } else if (type == 'Earthquake') {
      return CircleAvatar(
        backgroundImage: AssetImage('assets/images/earthquakes.png'),
        backgroundColor: Colors.transparent,
      );
    } else {
      return CircleAvatar(
        backgroundImage: AssetImage('assets/images/wildfire.png'),
      );
    }
  }

  @override
  void didChangeDependencies() {
    ApplicationProvider applicationProvider =
        Provider.of<ApplicationProvider>(context);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (widget.tempList.length > 0) {
      if (applicationProvider.applicationList.length > 0) {
        for (int i = 0; i < applicationProvider.applicationList.length; i++) {
          for (int j = 0; j < widget.tempList.length; j++) {
            widget.tempList.removeWhere((element) =>
                element.tripId ==
                applicationProvider.applicationList[i].tripId);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TripProvider tripProvider = Provider.of<TripProvider>(context);
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    ApplicationProvider applicationProvider =
        Provider.of<ApplicationProvider>(context);
    VolunteerProvider volunteerProvider =
        Provider.of<VolunteerProvider>(context);

    if (widget.tempList.length != 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Trips Application'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: ListTile(
                      leading: crisisIcons(widget.tempList[index].crisisType),
                      title: Text(
                        '${widget.tempList[index].crisisType}',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          children: [
                            Text(
                                'Required Volunteer: ${widget.tempList[index].numVolunteers}'),
                            Text('Country: ${widget.tempList[index].location}'),
                          ],
                        ),
                      ),
                      trailing: ElevatedButton(
                        child: Text('Apply'),
                        onPressed: () async {
                          for (int i = 0;
                              i < tripProvider.staffsTrip.length;
                              i++) {
                            for (int j = 0; j < widget.tempList.length; j++) {
                              if (widget.tempList[index].tripId ==
                                  tripProvider.staffsTrip[i].tripId) {
                                index2 = j;
                                // print(widget.tempList[i].tripId);
                              }
                            }
                          }
                          Application newApplication = Application(
                            applicationDate: DateTime.now().toString(),
                            status: 'New',
                            tripId: widget.tempList[index].tripId,
                            volunteerId: volunteerProvider.currentVolunteer.id,
                            staffId: widget.tempList[index].staffId,
                            tripDate: widget.tempList[index].tripDate,
                            description: widget.tempList[index].description,
                          );
                          applicationProvider.addApplication(newApplication);
                        },
                      ),
                    ),
                  );
                },
                itemCount: widget.tempList.length,
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AlertDialog(
                title: Text('No trips available'),
                content: Text('There is no trips available to apply yet!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Go Back'),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

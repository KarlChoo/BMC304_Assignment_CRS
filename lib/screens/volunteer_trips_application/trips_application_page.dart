import 'package:bmc304_assignment_crs/models/application.dart';
import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:bmc304_assignment_crs/providers/application_provider.dart';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_home/home_screen.dart';
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
    } else if (type == 'Wildfire') {
      return CircleAvatar(
        backgroundImage: AssetImage('assets/images/wildfire.png'),
      );
    } else {
      return CircleAvatar(
        backgroundImage: AssetImage('assets/images/otherdisaster.jpg'),
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
        if (widget.tempList.length > 0) {
          for (int m = 0; m < widget.tempList.length; m++) {
            if (widget.tempList[m].availableNumVolunteers == 0) {
              widget.tempList.removeAt(m);
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                'Slot Available: ${widget.tempList[index].availableNumVolunteers}'),
                            Text('Country: ${widget.tempList[index].location}'),
                          ],
                        ),
                      ),
                      trailing: ElevatedButton(
                        child: Text('Apply'),
                        onPressed: () async {
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
                          if (widget.tempList.length == 1) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Warning!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content:
                                        Text('You have applied all the trips!'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator
                                              .pushNamedAndRemoveUntil(
                                                  context,
                                                  HomeScreen.routeName,
                                                  (Route<dynamic> route) =>
                                                      false);
                                        },
                                        child: Text('OK'),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.orangeAccent),
                                      ),
                                    ],
                                  );
                                });
                          }
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

import 'package:bmc304_assignment_crs/models/application.dart';
import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripsApplication extends StatefulWidget {
  static const routeName = '/Trips_application';
  @override
  _TripsApplicationState createState() => _TripsApplicationState();
}

class _TripsApplicationState extends State<TripsApplication> {
  bool isEnabled = true;
  List<Trip> tempList = [];
  crisisIcons(String type) {
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    String image;

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
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    VolunteerProvider volunteerProvider =
        Provider.of<VolunteerProvider>(context);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      staffProvider.getAllTrips();
      volunteerProvider
          .getAllApplication(volunteerProvider.currentVolunteer.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    VolunteerProvider volunteerProvider =
        Provider.of<VolunteerProvider>(context);
    tempList = staffProvider.staffsTrip;
    if (tempList.length > 0) {
      for (int i = 0; i < volunteerProvider.applicationList.length; i++) {
        for (int j = 0; j < tempList.length; j++) {
          tempList.removeWhere((element) =>
              element.tripId == volunteerProvider.applicationList[i].tripId);
        }
      }
    }
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
                    leading: crisisIcons(tempList[index].crisisType),
                    title: Text(
                      '${tempList[index].crisisType}',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        children: [
                          Text(
                              'Required Volunteer: ${tempList[index].numVolunteers}'),
                          Text('Country: ${tempList[index].location}'),
                        ],
                      ),
                    ),
                    trailing: ElevatedButton(
                      child: Text('Apply'),
                      onPressed: () async {
                        Application newApplication = Application(
                            applicationDate: DateTime.now().toString(),
                            status: 'New',
                            tripId: staffProvider.staffsTrip[index].tripId,
                            volunteerId: volunteerProvider.currentVolunteer.id,
                            staffId: staffProvider.staffsTrip[index].staffId);
                        volunteerProvider.addApplication(newApplication);
                      },
                    ),
                  ),
                );
              },
              itemCount: staffProvider.staffsTrip.length,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationStatus extends StatefulWidget {
  static const routeName = '/Application_status';
  @override
  _ApplicationStatusState createState() => _ApplicationStatusState();
}

class _ApplicationStatusState extends State<ApplicationStatus> {
  @override
  Widget build(BuildContext context) {
    VolunteerProvider volunteerProvider =
        Provider.of<VolunteerProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Application Status'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    Text(volunteerProvider.applicationList[index].status),
                    Text(volunteerProvider.applicationList[index].tripDate),
                  ],
                ),
              ),
            );
          },
          itemCount: volunteerProvider.applicationList.length,
        ));
  }
}

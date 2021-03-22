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
  void didChangeDependencies() async {
    VolunteerProvider volunteerProvider =
        Provider.of<VolunteerProvider>(context);

    super.didChangeDependencies();
  }

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
                child: Text(volunteerProvider.applicationList[index].status),
              ),
            );
          },
          itemCount: volunteerProvider.applicationList.length,
        ));
  }
}

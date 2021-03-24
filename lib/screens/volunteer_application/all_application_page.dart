import 'package:bmc304_assignment_crs/providers/application_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllApplication extends StatefulWidget {
  static const routeName = '/All_application';
  @override
  _AllApplicationState createState() => _AllApplicationState();
}

class _AllApplicationState extends State<AllApplication> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    ApplicationProvider applicationProvider =
        Provider.of<ApplicationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('All Application'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: applicationProvider.applicationList[index].status == 'New'
                ? Text(
                    '${index + 1}. The trip is applying...',
                    style: TextStyle(color: Colors.black),
                  )
                : Text(
                    '${index + 1}. ${applicationProvider.applicationList[index].status}'),
            subtitle: Text(applicationProvider.applicationList[index].tripDate),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(),
              ),
            ],
          );
        },
        itemCount: applicationProvider.applicationList.length,
      ),
    );
  }

  showContainer() {
    return Container(
      child: Text('test'),
    );
  }
}

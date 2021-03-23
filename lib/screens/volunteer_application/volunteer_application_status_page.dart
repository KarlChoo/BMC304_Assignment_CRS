import 'package:bmc304_assignment_crs/models/application.dart';
import 'package:bmc304_assignment_crs/providers/application_provider.dart';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationStatus extends StatefulWidget {
  static const routeName = '/Application_status';
  @override
  _ApplicationStatusState createState() => _ApplicationStatusState();
}

class _ApplicationStatusState extends State<ApplicationStatus> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    ApplicationProvider applicationProvider =
        Provider.of<ApplicationProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Application List'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: applicationProvider.applicationList[index].status ==
                        'New'
                    ? Text(
                        '${index + 1}. The trip is applying...',
                        style: TextStyle(color: Colors.black),
                      )
                    : Text(
                        '${index + 1}. ${applicationProvider.applicationList[index].status}'),
                subtitle:
                    Text(applicationProvider.applicationList[index].tripDate),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_right_outlined),
                  onPressed: () {
                    showBottomSheet(
                        context: context,
                        builder: (context) => Container(
                              height: 225,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.shade200, width: 2),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      topLeft: Radius.circular(16))),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                        color: Colors.grey.shade300,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Application Status: ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        '${applicationProvider.applicationList[index].status}',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Trip Date: ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        '${applicationProvider.applicationList[index].tripDate}',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Description: ',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        '${applicationProvider.applicationList[index].description}',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Remarks: ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  Spacer(),
                                                  applicationProvider
                                                              .applicationList[
                                                                  index]
                                                              .remarks !=
                                                          null
                                                      ? Text(
                                                          '${applicationProvider.applicationList[index].remarks}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16))
                                                      : Text('-'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  },
                  color: Colors.blue,
                ),
              ),
            );
          },
          itemCount: applicationProvider.applicationList.length,
        ));
  }

  showDetailBottomSheet(BuildContext context, Application application) {
    return _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  color: Colors.grey.shade300,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Text(
                                  'Application Status: ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                Spacer(),
                                Text(
                                  '${application.status}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Text(
                                  'Trip Date: ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                Spacer(),
                                Text(
                                  '${application.tripDate}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Text(
                                  'Description: ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                Spacer(),
                                Text(
                                  '${application.description}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Remarks: ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Spacer(),
                            application.remarks != null
                                ? Text('${application.remarks}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16))
                                : Text('-'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 2);
  }
}

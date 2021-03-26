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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ExpansionTile(
              leading: CircleAvatar(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                backgroundColor: Colors.orange,
              ),
              title: Text(
                  '${applicationProvider.applicationList[index].applicationDate.substring(0, 10)}'),
              subtitle: Text(
                '${applicationProvider.applicationList[index].applicationId}',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Trip date:',
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${applicationProvider.applicationList[index].tripDate}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Description:',
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${applicationProvider.applicationList[index].description}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 20, bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Status:',
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${applicationProvider.applicationList[index].status}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Remarks:',
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: applicationProvider
                                            .applicationList[index].remarks ==
                                        null
                                    ? Text('-')
                                    : Text(
                                        '${applicationProvider.applicationList[index].remarks}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          itemCount: applicationProvider.applicationList.length,
        ),
      ),
    );
  }

  showContainer() {
    return Container(
      child: Text('test'),
    );
  }
}

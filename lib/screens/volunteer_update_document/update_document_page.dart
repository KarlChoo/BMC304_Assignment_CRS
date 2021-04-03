import 'package:bmc304_assignment_crs/constants.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_update_document/upload_images_page.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateDocumentPage extends StatefulWidget {
  static const routeName = '/UpdateDocument';
  @override
  _UpdateDocumentPageState createState() => _UpdateDocumentPageState();
}

class _UpdateDocumentPageState extends State<UpdateDocumentPage> {
  String date = '';
  String selectValue = 'Passport';
  showDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      currentDate: DateTime(2021, 11, 19),
      initialDate: DateTime(2021, 11, 17),
      firstDate: DateTime(2021, 1),
      lastDate: DateTime(2030, 7),
      helpText: 'Select a date',
    );
    setState(() {
      date = formatDate(
        newDate,
        [dd, '-', mm, '-', yyyy],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> documentType = [
      DropdownMenuItem(
        child: Text('Passport'),
        value: 'Passport',
      ),
      DropdownMenuItem(
        child: Text('Certificate'),
        value: 'Certificate',
      ),
      DropdownMenuItem(
        child: Text('Visa'),
        value: 'Visa',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Document'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: IntrinsicWidth(
                    stepWidth: double.infinity,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: documentType,
                      value: selectValue,
                      onChanged: (newValue) {
                        setState(() {
                          selectValue = newValue;
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: ElevatedButton(
                            onPressed: () {
                              showDate();
                            },
                            style: ElevatedButton.styleFrom(
                                primary: kPrimaryColor),
                            child: Text('Expiry Date (Optional)')),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '${date}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadImagePage(
                              selectedDate: date,
                              selectedValue: selectValue,
                            )));
              },
              style: ElevatedButton.styleFrom(primary: kPrimaryColor),
              child: Text('Next')),
        ),
      ),
    );
  }
}

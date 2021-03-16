import 'dart:io';

import 'package:bmc304_assignment_crs/constants.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class UpdateDocumentPage extends StatefulWidget {
  static const routeName = '/UpdateDocument';
  @override
  _UpdateDocumentPageState createState() => _UpdateDocumentPageState();
}

class _UpdateDocumentPageState extends State<UpdateDocumentPage> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
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
        title: Text('Update Document'),
      ),
      body: Padding(
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
              Text('${date}'),
              IntrinsicWidth(
                stepWidth: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      showDate();
                    },
                    style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                    child: Text('Expiry Date')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: IntrinsicWidth(
                  stepWidth: double.infinity,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Colors.white),
                    ),
                    color: kPrimaryColor,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((context) => bottomSheet()),
                      );
                    },
                    child: IconButton(
                      icon: Icon(Icons.file_upload),
                      iconSize: 40,
                    ),
                  ),
                ),
              ),
              Text(
                'Upload Document',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                          backgroundImage: _imageFile == null
                              ? AssetImage("assets/images/Profile Image.png")
                              : FileImage(File(_imageFile.path))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Image",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              )
            ],
          ),
        ],
      ),
    );
  }
}

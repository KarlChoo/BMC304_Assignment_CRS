import 'dart:io';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_home/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bmc304_assignment_crs/models/document.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class UploadImagePage extends StatefulWidget {
  static const routeName = '/Upload_image';
  final String selectedValue;
  final String selectedDate;

  UploadImagePage({this.selectedValue, this.selectedDate});
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  File _imageFile;
  final ImagePicker _picker = ImagePicker();
  TextEditingController certName = TextEditingController();
  TextEditingController visaCountry = TextEditingController();
  String _imageUrl;
  String fileName = 'uploads/';
  String fileUrl;
  @override
  Widget build(BuildContext context) {
    VolunteerProvider volunteerProvider =
        Provider.of<VolunteerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Images'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              widget.selectedValue == 'Certificate'
                  ? TextFormField(
                      controller: certName,
                      decoration: InputDecoration(
                        labelText: 'Document Name',
                      ),
                    )
                  : Container(),
              widget.selectedValue == 'Visa'
                  ? TextFormField(
                      controller: visaCountry,
                      decoration: InputDecoration(
                        labelText: 'Visa Country',
                      ),
                    )
                  : Container(),
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
                padding: const EdgeInsets.only(top: 40, bottom: 80),
                child: SizedBox(
                  height: 115,
                  width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                          backgroundImage: _imageFile == null
                              ? AssetImage("assets/images/Profile Image.png")
                              : FileImage(_imageFile)),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text('Upload Document'),
                      onPressed: () async {
                        if (_imageFile != null) {
                          await uploadImageToFirebase(context);
                          print(fileUrl);
                          Document newDocument = Document(
                            documentType: widget.selectedValue,
                            documentImage: fileUrl,
                            volunteerId: volunteerProvider.currentVolunteer.id,
                            expiryDate: widget.selectedDate,
                          );
                          volunteerProvider.addDocument(newDocument);
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              HomeScreen.routeName,
                              (Route<dynamic> route) => false);
                        } else if (widget.selectedValue == 'Certificate') {
                          if (certName.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Warning!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                        'Please fill in the name of document!'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.transparent),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            await uploadImageToFirebase(context);
                            Document newDocument = Document(
                                documentType: widget.selectedValue,
                                documentImage: fileUrl,
                                volunteerId:
                                    volunteerProvider.currentVolunteer.id,
                                expiryDate: widget.selectedDate,
                                certName: certName.text);
                            volunteerProvider.addDocument(newDocument);
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeScreen.routeName,
                                (Route<dynamic> route) => false);
                          }
                        } else if (widget.selectedValue == 'Visa') {
                          if (visaCountry.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Warning!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                        'Please fill in the country of the country!'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.transparent),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            await uploadImageToFirebase(context);
                            Document newDocument = Document(
                              documentType: widget.selectedValue,
                              documentImage: fileUrl,
                              volunteerId:
                                  volunteerProvider.currentVolunteer.id,
                              expiryDate: widget.selectedDate,
                              visaCountry: visaCountry.text,
                            );
                            volunteerProvider.addDocument(newDocument);
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeScreen.routeName,
                                (Route<dynamic> route) => false);
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    'Warning!',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  content: Text(
                                      'Please upload an images of document!'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                    ),
                  ),
                ],
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
      _imageFile = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    await taskSnapshot.ref.getDownloadURL().then((value) => fileUrl = value);
  }

  Future getFirebaseImageFolder() async {
    StorageReference _reference =
        FirebaseStorage.instance.ref().child('uploads/$fileName.jpg');
    String downloadAddress = await _reference.getDownloadURL();
    setState(() {
      _imageUrl = downloadAddress;
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
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

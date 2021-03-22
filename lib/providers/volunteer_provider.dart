import 'package:bmc304_assignment_crs/models/staff.dart';
import 'package:bmc304_assignment_crs/models/user.dart';
import 'package:bmc304_assignment_crs/models/volunteer.dart';
import 'package:flutter/material.dart';
import 'package:bmc304_assignment_crs/models/document.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VolunteerProvider with ChangeNotifier {
  Volunteer currentVolunteer;
  List<Volunteer> _systemVolunteers = [];
  List<Document> _documentList = [];
  List<Volunteer> get systemVolunteers => _systemVolunteers;

  List<Document> get documentList {
    return [..._documentList];
  }

  Uri volunteerFileURL = Uri.parse(
      "https://bmc304-67ba7-default-rtdb.firebaseio.com/volunteers.json");

  Future<User> login(String username, String password) async {
    try {
      final response = await http.get(volunteerFileURL);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData != null && extractedData.length > 0) {
        extractedData.forEach((userId, userdata) {
          if (userdata['username'] == username &&
              userdata['password'] == password) {
            Volunteer newVolunteer = Volunteer(
              id: userId,
              username: userdata['username'],
              password: userdata['password'],
              email: userdata['email'],
              phone: userdata['phone'],
              address: userdata['address'],
              firstName: userdata['firstName'],
              lastName: userdata['lastName'],
            );
            currentVolunteer = newVolunteer;
          }
        });
      }
      return currentVolunteer; //if there is no match (username and password), this method return null
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> getAllDocument(String id) async {
    try {
      Uri volunteerDocument = Uri.parse(
          "https://bmc304-67ba7-default-rtdb.firebaseio.com/documents.json");
      final response = await http.get(volunteerDocument);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData != null && extractedData.length > 0) {
        extractedData.forEach((documentId, documentData) {
          Document newDocument = Document(
            id: documentId,
            documentType: documentData['documentType'],
            documentImage: documentData['documentImage'],
            volunteerId: documentData['volunteerId'],
            certName: documentData['certName'],
            visaCountry: documentData['visaCountry'],
            expiryDate: documentData['expiryDate'],
          );
          if (newDocument.volunteerId == id) {
            _documentList.add(newDocument);
          }
        });
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  //Needs to be cross checked with the array in staff array through provider
  Future<bool> isVolunteerExist(String username) async {
    bool result = false;
    try {
      final response = await http.get(volunteerFileURL);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData != null && extractedData.length > 0) {
        extractedData.forEach((userId, userdata) {
          if (userdata['username'] == username) {
            result = true;
            return;
          }
        });
      }
    } catch (error) {
      print(error);
    }
    return result;
  }

  Future<Volunteer> addVolunteer(Volunteer volunteer) async {
    final response = await http.post(volunteerFileURL,
        body: json.encode({
          'username': volunteer.username,
          'password': volunteer.password,
          'email': volunteer.email,
          'phone': volunteer.phone,
          'address': volunteer.address,
          'firstName': volunteer.firstName,
          'lastName': volunteer.lastName,
        }));
    Volunteer newVolunteer = Volunteer(
      id: json.decode(
          response.body)['name'], //name is the database name for the data
      username: volunteer.username,
      firstName: volunteer.firstName,
      lastName: volunteer.lastName,
      password: volunteer.password,
      email: volunteer.email,
      phone: volunteer.phone,
      address: volunteer.address,
    );
    currentVolunteer = newVolunteer;
    notifyListeners();
    return currentVolunteer;
  }

  Future<void> addDocument(Document document) async {
    Uri volunteerDocument = Uri.parse(
        "https://bmc304-67ba7-default-rtdb.firebaseio.com/documents.json");
    if (document.documentType == 'Certificate') {
      final response = await http.post(volunteerDocument,
          body: json.encode({
            'documentType': document.documentType,
            'documentImage': document.documentImage,
            'volunteerId': document.volunteerId,
            'certName': document.certName,
            'expiryDate': document.expiryDate,
          }));
      Document newDocument = Document(
        id: json.decode(response.body)['name'],
        documentImage: document.documentImage,
        documentType: document.documentType,
        certName: document.certName,
        volunteerId: document.volunteerId,
      );
      _documentList.add(newDocument);
    } else if (document.documentType == 'Visa') {
      final response = await http.post(volunteerDocument,
          body: json.encode({
            'documentType': document.documentType,
            'documentImage': document.documentImage,
            'expiryDate': document.expiryDate,
            'volunteerId': document.volunteerId,
            'visaCountry': document.visaCountry,
          }));
      Document newDocument = Document(
        id: json.decode(response.body)['name'],
        //name is the database name for the data
        documentImage: document.documentImage,
        documentType: document.documentType,
        expiryDate: document.expiryDate,
        visaCountry: document.visaCountry,
        volunteerId: document.volunteerId,
      );
      _documentList.add(newDocument);
    } else {
      final response = await http.post(volunteerDocument,
          body: json.encode({
            'documentType': document.documentType,
            'documentImage': document.documentImage,
            'expiryDate': document.expiryDate,
            'volunteerId': document.volunteerId,
          }));
      Document newDocument = Document(
        id: json.decode(response.body)['name'],
        //name is the database name for the data
        documentImage: document.documentImage,
        documentType: document.documentType,
        expiryDate: document.expiryDate,
        volunteerId: document.volunteerId,
      );
      _documentList.add(newDocument);
    }
    notifyListeners();
  }

  Future<void> signoutVolunteer() async {
    // currentVolunteer = Volunteer(
    //   username: '',
    //   password: '',
    //   phone: '',
    //   email: '',
    //   address: '',
    //   firstName: '',
    //   lastName: '',
    // );
    currentVolunteer = null;
  }

  Future<void> updateVolunteerProfile(Volunteer volunteer) async {
    Uri uri = Uri.parse(
        "https://bmc304-67ba7-default-rtdb.firebaseio.com/volunteers/${volunteer.id}.json");

    try {
      await http.patch(uri,
          body: json.encode({
            'firstName': volunteer.firstName,
            'lastName': volunteer.lastName,
            'phone': volunteer.phone,
            'password': volunteer.password,
          }));
      currentVolunteer = volunteer;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

// Future<void> populateData() async{
  //   try{
  //     // List<User> sampleUsers = [
  //     //
  //     // ];
  //     // final response = await http.post(Uri.parse(userURL));
  //   } catch (error) {
  //
  //   }
  // }
}

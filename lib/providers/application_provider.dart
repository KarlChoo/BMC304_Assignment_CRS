import 'dart:convert';
import 'package:bmc304_assignment_crs/models/application.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApplicationProvider with ChangeNotifier {
  List<Application> get applicationList {
    return [..._applicationList];
  }

  List<Application> _applicationList = [];
  Uri volunteerApplication = Uri.parse(
      "https://bmc304-67ba7-default-rtdb.firebaseio.com/applications.json");

  Future<void> getAllApplication(String volunteerId) async {
    try {
      final response = await http.get(volunteerApplication);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData != null && extractedData.length > 0) {
        this.clearApplicationList();
        extractedData.forEach((applicationId, applicationData) {
          Application newApplication = Application(
            applicationId: applicationId,
            applicationDate: applicationData['applicationDate'],
            description: applicationData['description'],
            status: applicationData['status'],
            volunteerId: applicationData['volunteerId'],
            remarks: applicationData['remarks'],
            tripId: applicationData['tripId'],
            staffId: applicationData['staffId'],
            tripDate: applicationData['tripDate'],
          );
          if (newApplication.volunteerId == volunteerId) {
            _applicationList.add(newApplication);
          }
        });
      }
    } catch (error) {
      print(error);
      return null;
    }
  }


  Future<void> getApplicationOfAdmin(String staffId) async {
    this.clearApplicationList();
    try {
      final response = await http.get(volunteerApplication);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData != null && extractedData.length > 0) {
        extractedData.forEach((applicationId, applicationData) {
          Application newApplication = Application(
            applicationId: applicationId,
            applicationDate: applicationData['applicationDate'],
            description: applicationData['description'],
            status: applicationData['status'],
            volunteerId: applicationData['volunteerId'],
            remarks: applicationData['remarks'],
            tripId: applicationData['tripId'],
            staffId: applicationData['staffId'],
            tripDate: applicationData['tripDate'],
          );
          if (newApplication.staffId == staffId) {
            _applicationList.add(newApplication);
          }
        });
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> addApplication(Application application) async {
    final response = await http.post(volunteerApplication,
        body: json.encode({
          'applicationDate': application.applicationDate,
          'status': application.status,
          'remarks': application.remarks,
          'tripId': application.tripId,
          'volunteerId': application.volunteerId,
          'staffId': application.staffId,
          'tripDate': application.tripDate,
          'description': application.description,
        }));
    Application newApplication = Application(
      applicationId: json.decode(
          response.body)['name'], //name is the database name for the data
      applicationDate: application.applicationDate,
      status: application.status,
      remarks: application.remarks,
      tripId: application.tripId,
      volunteerId: application.volunteerId,
      staffId: application.staffId,
      tripDate: application.tripDate,
      description: application.description,
    );
    _applicationList.add(newApplication);
    notifyListeners();
  }

  Future<bool> updateStatus(Application application, String newStatus) async {
    try {
      String updatestatusUrl =
          "https://bmc304-67ba7-default-rtdb.firebaseio.com/applications/${application.applicationId}.json";
      final response = await http.patch(Uri.parse(updatestatusUrl),
          body: json.encode({"status": newStatus}));
      if (response.statusCode == 200) {
        final applicationIndex = applicationList.indexWhere((arrApplication) =>
            arrApplication.applicationId == application.applicationId);
        applicationList[applicationIndex].status = newStatus;
        notifyListeners();
        return true;
      }
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<void> clearApplicationList() {
    _applicationList = [];
  }
}

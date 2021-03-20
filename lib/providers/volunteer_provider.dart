import 'package:bmc304_assignment_crs/models/staff.dart';
import 'package:bmc304_assignment_crs/models/user.dart';
import 'package:bmc304_assignment_crs/models/volunteer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VolunteerProvider with ChangeNotifier {
  Volunteer currentVolunteer;
  List<Volunteer> _systemVolunteers = [];
  List<Volunteer> get systemVolunteers => _systemVolunteers;

  List<Volunteer> volunteers = [];
  List<Staff> staffs = [];

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

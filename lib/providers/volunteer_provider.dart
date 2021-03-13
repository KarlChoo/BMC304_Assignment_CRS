import 'package:bmc304_assignment_crs/models/staff.dart';
import 'package:bmc304_assignment_crs/models/user.dart';
import 'package:bmc304_assignment_crs/models/volunteer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VolunteerProvider with ChangeNotifier{

  User currentVolunteer;
  List<User> _systemVolunteers = [];
  List<User> get systemVolunteers => _systemVolunteers;

  List<Volunteer> volunteers = [];
  List<Staff> staffs = [];

  String volunteerFileURL = "https://bmc304-67ba7-default-rtdb.firebaseio.com/volunteers.json";

  Future<User> login(String username, String password) async{
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
  Future<bool> isUserExist(String username) async {
    bool result = false;
    try {
      final response = await http.get(volunteerFileURL);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData != null && extractedData.length > 0) {
        extractedData.forEach((userId, userdata) {
          if (userdata['username'] == username) {
            result = true;
          }
        });
      }
    } catch (error) {
      print(error);
    }
    return result;
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
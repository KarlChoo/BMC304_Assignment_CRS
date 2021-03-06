import 'package:bmc304_assignment_crs/models/staff.dart';
import 'package:bmc304_assignment_crs/models/user.dart';
import 'package:bmc304_assignment_crs/models/volunteer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier{

  User currentUser;
  List<User> _systemUsers = [];
  List<User> get systemUsers => _systemUsers;

  List<Volunteer> volunteers = [];
  List<Staff> staffs = [];

  String userURL = "https://bmc304-67ba7-default-rtdb.firebaseio.com/users.json";

  Future<User> login(String username, String password) async{
    try {
      final response = await http.get(Uri.parse(userURL));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      if(extractedData != null && extractedData.length > 0){
        extractedData.forEach((userId, userData) {
          if(userData['username'] == username && userData['password'] == password){
            // User newUser = User(
            //   id: userId,
            //   username: userData['username'],
            //   password: userData['password'],
            //   phone: '', address: '', email: ''
            // );
            // currentUser = newUser;
          }
        });
      }
      return currentUser;
    } catch (error) {
      print(error);
    }
  }

  Future<void> populateData() async{
    try{
      // List<User> sampleUsers = [
      //
      // ];
      // final response = await http.post(Uri.parse(userURL));
    } catch (error) {

    }
  }
}
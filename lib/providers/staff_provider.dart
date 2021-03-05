import 'dart:convert';

import 'package:bmc304_assignment_crs/models/staff.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StaffProvider extends ChangeNotifier {
  Staff currentStaff;

  Future<Staff> login(String username, String password) async {
    String url = 'https://bmc304-67ba7-default-rtdb.firebaseio.com/staffs.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData != null && extractedData.length > 0) {
      extractedData.forEach((userId, userdata) {
        if (userdata['username'] == username &&
            userdata['password'] == password) {
          Staff newStaff = Staff(
            id: userId,
            username: userdata['username'],
            password: userdata['password'],
            email: userdata['email'],
            phone: userdata['phone'],
            address: userdata['address'],
            position: userdata['position'],
            dateJoined: userdata['dateJoined'],
          );
          currentStaff = newStaff;
        }
      });
    }
    return currentStaff; //if there is no match (username and password), this method return null
  }

  Future<bool> isUserExist(String username) async {
    bool result = false;
    String url = 'https://bmc304-67ba7-default-rtdb.firebaseio.com/staffs.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData != null && extractedData.length > 0) {
      extractedData.forEach((userId, userdata) {
        if (userdata['username'] == username) {
          result = true;
        }
      });
    }
    return result;
  }

  Future<Staff> addStaff(Staff staff) async {
    String url = 'https://bmc304-67ba7-default-rtdb.firebaseio.com/staffs.json';
    final response = await http.post(url,
        body: json.encode({
          'username': staff.username,
          'password': staff.password,
          'email': staff.email,
          'phone': staff.phone,
          'address': staff.address,
          'position': staff.position,
          'dateJoined': staff.dateJoined,
        }));
    Staff newStaff = Staff(
      id: json.decode(
          response.body)['name'], //name is the database name for the data
      username: staff.username,
      password: staff.password,
      email: staff.email,
      phone: staff.phone,
      address: staff.address,
      position: staff.position,
      dateJoined: staff.dateJoined,
    );
    currentStaff = newStaff;
    notifyListeners();
    return currentStaff;
  }

  Future<void> signoutUser() async {
    currentStaff = Staff(
        username: '',
        password: '',
        phone: '',
        email: '',
        address: '',
        position: '',
        dateJoined: null);
  }
}

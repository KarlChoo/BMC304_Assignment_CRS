import 'dart:convert';

import 'package:bmc304_assignment_crs/models/staff.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StaffProvider extends ChangeNotifier {
  Staff currentStaff;
  List<Staff> _systemStaffs = [];
  List<Staff> get systemStaffs => _systemStaffs;

  List<Staff> staffs = [];

  Future<Staff> login(String username, String password) async {
    try {
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
    } catch (error) {
      print(error);
    }
    return currentStaff; //if there is no match (username and password), this method return null
  }

  Future<bool> isUserExist(String username) async {
    try {
      String url = 'https://bmc304-67ba7-default-rtdb.firebaseio.com/staffs.json';
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData != null && extractedData.length > 0) {
        extractedData.forEach((userId, userdata) {
          if (userdata['username'] == username) {
            return true;
          }
        });
      }
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<Staff> addStaff(Staff staff) async {
    try {
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
        id: json.decode(response.body)['name'], //name is the database name for the data id
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
    } catch (error) {
      print(error);
    }
    return currentStaff;
  }

  Future<void> signoutStaff() async {
    currentStaff = Staff(
        username: '',
        password: '',
        phone: '',
        email: '',
        address: '',
        position: '',
        dateJoined: null
    );
  }
}

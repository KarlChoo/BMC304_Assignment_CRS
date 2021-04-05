import 'dart:convert';

import 'package:bmc304_assignment_crs/models/staff.dart';
import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StaffProvider extends ChangeNotifier {
  Staff currentStaff;
  List<Staff> _systemStaffs = [];
  List<Staff> get systemStaffs => _systemStaffs;

  String url = 'https://bmc304-67ba7-default-rtdb.firebaseio.com/staffs.json';
  String paramUrl = 'https://bmc304-67ba7-default-rtdb.firebaseio.com/staffs';
  Future<void> getAllSystemStaff() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        print('getAllSystemStaff() method failed');
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Staff> loadingStaff = [];

      if (extractedData != null || extractedData.length > 0) {
        extractedData.forEach((staffId, staffData) {
          Staff newStaff = Staff(
              id: staffId,
              username: staffData["username"],
              password: staffData["password"],
              firstName: staffData["firstName"],
              lastName: staffData["lastName"],
              email: staffData["email"],
              address: staffData["address"],
              phone: staffData["phone"],
              position: staffData["position"],
              suspended: staffData['suspended'],
              dateJoined: staffData["dateJoined"]);
          loadingStaff.add(newStaff);
        });
        _systemStaffs = loadingStaff;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  List<Staff> getAllCRSAdmin() {
    final List<Staff> adminList = [];

    systemStaffs.forEach((staff) {
      if (staff.position == "Admin") adminList.add(staff);
    });
    return adminList;
  }

  List<Staff> getAllCRSManager() {
    final List<Staff> managerList = [];

    systemStaffs.forEach((staff) {
      if (staff.position == "Manager" || staff.position == "Director")
        managerList.add(staff);
    });
    return managerList;
  }

  void updateOwnDetails() {
    systemStaffs.forEach((staff) {
      if (staff.id == currentStaff.id) currentStaff = staff;
    });
  }

  Future<int> login(String username, String password) async {
    // 0 = login success
    // 1 = login failed (account does not exist)
    // 2 = account suspended
    int responseCode = 1;
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) print('login() method failed');

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData != null && extractedData.length > 0) {
        extractedData.forEach((userId, userdata) {
          if (userdata['username'] == username &&
              userdata['password'] == password) {
            if (userdata['suspended']) {
              responseCode = 2;
              return;
            }

            Staff newStaff = Staff(
              id: userId,
              username: userdata['username'],
              password: userdata['password'],
              firstName: userdata["firstName"],
              lastName: userdata["lastName"],
              email: userdata['email'],
              phone: userdata['phone'],
              address: userdata['address'],
              position: userdata['position'],
              suspended: userdata['suspended'],
              dateJoined: userdata['dateJoined'],
            );
            currentStaff = newStaff;
            responseCode = 0;
            return;
          }
        });
      }
    } catch (error) {
      print(error);
    }
    return responseCode;
  }

  Future<bool> isUserExist(String username) async {
    bool result = false;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        print('isUserExist() method failed');
        return false;
      }
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

  Future<bool> addStaff(Staff staff) async {
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'username': staff.username,
            'password': staff.password,
            'firstName': staff.firstName,
            'lastName': staff.lastName,
            'email': staff.email,
            'phone': staff.phone,
            'address': staff.address,
            'suspended': staff.suspended,
            'position': staff.position,
            'dateJoined': staff.dateJoined,
          }));
      //Add to local array only if operation success
      if (response.statusCode == 200) {
        String id = json.decode(response.body)['name'];
        staff.id = id;
        systemStaffs.add(staff);
        notifyListeners();
        return true;
      } else {
        print('addStaff() method failed');
      }
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<bool> updateStaff(Staff staff) async {
    try {
      String editUrl = "$paramUrl/${staff.id}.json";
      final response = await http.patch(Uri.parse(editUrl),
          body: json.encode({
            'username': staff.username,
            'password': staff.password,
            'firstName': staff.firstName,
            'lastName': staff.lastName,
            'email': staff.email,
            'phone': staff.phone,
            'address': staff.address,
            'suspended': staff.suspended,
            'position': staff.position,
            'dateJoined': staff.dateJoined,
          }));

      //Update only if backend operation is successful
      if (response.statusCode == 200) {
        final staffIndex =
            systemStaffs.indexWhere((arrStaff) => arrStaff.id == staff.id);
        systemStaffs[staffIndex] = staff;
        notifyListeners();
        return true;
      } else {
        print('updateStaff() method failed');
      }
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<bool> suspendStaff(Staff staff) async {
    try {
      String editUrl = "$paramUrl/${staff.id}.json";
      final response = await http.patch(Uri.parse(editUrl),
          body: json.encode({"suspended": !staff.suspended}));
      if (response.statusCode == 200) {
        final staffIndex =
            systemStaffs.indexWhere((arrStaff) => arrStaff.id == staff.id);
        systemStaffs[staffIndex].suspended =
            !systemStaffs[staffIndex].suspended;
        notifyListeners();
        return true;
      }
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<bool> deleteStaff(String staffId) async {
    try {
      String deleteUrl = "$paramUrl/$staffId.json";
      final response = await http.delete(Uri.parse(deleteUrl));
      if (response.statusCode == 200) {
        print('Test');
        systemStaffs.removeWhere((staff) => staff.id == staffId);
        notifyListeners();
        return true;
      }
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<void> signoutStaff() async {
    currentStaff = null;
  }
}

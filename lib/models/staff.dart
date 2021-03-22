import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:bmc304_assignment_crs/models/user.dart';
import 'package:flutter/material.dart';

class Staff extends User {
  final String position;
  bool suspended;
  final int dateJoined;

  //Trips are stored in id
  final List<String> organizedTrips = [];

  Staff(
      {String id,
      @required String username,
      @required String password,
      @required String firstName,
      @required String lastName,
      @required String email,
      @required String phone,
      @required String address,
      @required this.position,
      this.suspended = false,
      @required this.dateJoined})
      : super(
        username: username,
        password: password,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        address: address,
        id: id
      );
}

import 'package:bmc304_assignment_crs/models/user.dart';
import 'package:flutter/material.dart';

class Staff extends User {
  final String position;
  final int dateJoined;
  Staff(
      {String id,
      @required String username,
      @required String password,
      @required String email,
      @required String phone,
      @required String address,
      @required this.position,
      @required this.dateJoined})
      : super(
            username: username,
            password: password,
            email: email,
            phone: phone,
            address: address,
            id: id);
}

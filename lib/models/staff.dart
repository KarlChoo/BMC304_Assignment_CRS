import 'package:bmc304_assignment_crs/models/user.dart';
import 'package:flutter/material.dart';

class Staff extends User{
  final String position;
  final DateTime dateJoined;
  Staff({
    id,
    @required username,
    @required password,
    @required email,
    @required phone,
    @required address,
    @required this.position,
    @required this.dateJoined
  });
}
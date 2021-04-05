import 'package:flutter/material.dart';

abstract class User with ChangeNotifier {
  String id;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  User({
    this.id,
    @required this.username,
    @required this.password,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.phone,
    @required this.address,
  });
}

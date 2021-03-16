import 'package:flutter/material.dart';

abstract class User with ChangeNotifier {
  final String id;
  final String username;
  final String password;
  final String email;
  final String phone;
  final String address;
  final String firstName;
  final String lastName;

  User({
    this.id,
    @required this.username,
    @required this.password,
    @required this.email,
    @required this.phone,
    @required this.address,
    @required this.firstName,
    @required this.lastName,
  });
}

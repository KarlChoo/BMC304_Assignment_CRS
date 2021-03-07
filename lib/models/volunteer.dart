import 'package:bmc304_assignment_crs/models/application.dart';
import 'package:bmc304_assignment_crs/models/document.dart';
import 'package:bmc304_assignment_crs/models/user.dart';
import 'package:flutter/material.dart';

class Volunteer extends User {
   List<Document> volunteerDocument = [];
   List<Application> applicationList = [];

   Volunteer({
      id,
      @required username,
      @required password,
      @required email,
      @required phone,
      @required address,
   }): super(
       username: username,
       password: password,
       email: email,
       phone: phone,
       address: address,
       id: id
   );
}
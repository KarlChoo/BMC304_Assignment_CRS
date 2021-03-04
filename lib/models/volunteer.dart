import 'package:bmc304_assignment_crs/models/document.dart';
import 'package:bmc304_assignment_crs/models/user.dart';
import 'package:flutter/material.dart';

class Volunteer extends User {
   List<Document> volunteerDocument = [];
   Volunteer({
      id,
      @required username,
      @required password,
      @required email,
      @required phone,
      @required address,
      this.volunteerDocument
   });
}
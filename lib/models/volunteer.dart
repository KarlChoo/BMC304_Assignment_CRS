import 'package:bmc304_assignment_crs/models/application.dart';
import 'package:bmc304_assignment_crs/models/document.dart';
import 'package:bmc304_assignment_crs/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    @required firstName,
    @required lastName,
  }) : super(
            username: username,
            password: password,
            email: email,
            phone: phone,
            address: address,
            firstName: firstName,
            lastName: lastName,
            id: id);

  int applicationsCreated(){
    return this.applicationList.length;
  }

  int applicationsAccepted(){
    int count = 0;
    this.applicationList.forEach((application) {
      if(application.status == "Accepted") count++;
    });
    return count;
  }

  int applicationsRejected(){
    int count = 0;
    this.applicationList.forEach((application) {
      if(application.status == "Rejected") count++;
    });
    return count;
  }


}

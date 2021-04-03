import 'package:bmc304_assignment_crs/models/application.dart';
import 'package:flutter/material.dart';

class Trip with ChangeNotifier {
  final String tripId;
  final String description;
  final String tripDate;
  final String location;
  final String crisisType;
  final int numVolunteers;
  final String remark;
  int availableNumVolunteers;

  final String staffId;
  final List<Application> applicationList = [];

  Trip({
    this.tripId,
    @required this.description,
    @required this.tripDate,
    @required this.location,
    @required this.crisisType,
    @required this.numVolunteers,
    this.staffId,
    this.remark,
    this.availableNumVolunteers,
  });
}

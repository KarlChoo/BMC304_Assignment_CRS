import 'package:flutter/material.dart';

class Application with ChangeNotifier {
  final String applicationId;
  final int applicationDate;
  final String status = "New";
  final String remarks;

  final String tripId;
  final String volunteerId;

  Application({
    this.applicationId,
    @required this.applicationDate,
    @required this.remarks,
    @required this.tripId,
    @required this.volunteerId
  });

}
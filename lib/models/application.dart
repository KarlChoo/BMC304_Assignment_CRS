import 'package:flutter/material.dart';

class Application with ChangeNotifier {
  final String applicationId;
  final int applicationDate;
  final String status;
  final String remarks;

  final String tripId;
  final String volunteerId;
  final String staffId;

  Application(
      {this.applicationId,
      @required this.applicationDate,
      this.remarks,
      @required this.status,
      @required this.tripId,
      @required this.volunteerId,
      @required this.staffId});
}

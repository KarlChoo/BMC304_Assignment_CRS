import 'package:flutter/material.dart';

class Application with ChangeNotifier {
  final String applicationId;
  final String applicationDate;
  final String status;
  final String remarks;

  final String tripId;
  final String volunteerId;

  Application(
      {this.applicationId,
      @required this.applicationDate,
      @required this.remarks,
      @required this.status,
      @required this.tripId,
      @required this.volunteerId});
}

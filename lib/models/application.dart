import 'package:flutter/material.dart';

class Application with ChangeNotifier {
  final String applicationId;
  final DateTime applicationDate = DateTime.now();
  final String status = "NEW";
  final String remarks;

  final String tripId;
  final String volunteerId;

  Application({
    this.applicationId,
    @required this.remarks,
    @required this.tripId,
    @required this.volunteerId
  });

}
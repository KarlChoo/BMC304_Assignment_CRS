import 'package:flutter/material.dart';

class Document with ChangeNotifier {
  final String id;
  final String documentType;
  final DateTime expireDate;
  final Image documentImage;
  final String volunteerId;

  Document({
    this.id,
    @required this.documentType,
    @required this.expireDate,
    @required this.documentImage,
    @required this.volunteerId
  });
}
import 'package:flutter/material.dart';

class Document with ChangeNotifier {
  final String id;
  final String documentType;
  final String expiryDate;
  final String documentImage;
  final String volunteerId;
  final String certName;
  final String visaCountry;

  Document({
    this.id,
    @required this.documentType,
    this.expiryDate,
    @required this.documentImage,
    @required this.volunteerId,
    this.certName,
    this.visaCountry,
  });
}

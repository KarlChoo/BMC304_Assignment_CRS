import 'dart:convert';

import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TripProvider with ChangeNotifier {
  List<Trip> _staffTrip = [];

  List<Trip> get staffsTrip => _staffTrip;



  String tripsUrl =
      'https://bmc304-67ba7-default-rtdb.firebaseio.com/trips.json';

  Future<void> getAllTrips() async {
    try {
      final response = await http.get(Uri.parse(tripsUrl));
      if (response.statusCode != 200) print('getAllTrips() method failed');
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Trip> loadingTrips = [];

      if (extractedData != null || extractedData.length > 0) {
        extractedData.forEach((tripId, tripData) {
          Trip newTrip = Trip(
            tripId: tripId,
            description: tripData["description"],
            tripDate: tripData["tripDate"],
            location: tripData["location"],
            crisisType: tripData["crisisType"],
            numVolunteers: tripData["numVolunteers"],
            staffId: tripData['staffId'],
            remark: tripData["remark"],
          );
          loadingTrips.add(newTrip);
        });
        _staffTrip = loadingTrips;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  Trip getTrip(String tripId){
    return _staffTrip.singleWhere((trip) => trip.tripId == tripId);
  }

  List<Trip> getTripsByAdmin(String staffId){
    final List<Trip> tripList = [];

    staffsTrip.forEach((trip){
      if (trip.staffId == staffId){
        tripList.add(trip);
      }
    });
    return tripList;



  }

  Future<bool> addTrip(Trip trip) async {
    try {
      final response = await http.post(Uri.parse(tripsUrl),
          body: json.encode({
            'description': trip.description,
            'tripDate': trip.tripDate,
            'location': trip.location,
            'crisisType': trip.crisisType,
            'numVolunteers': trip.numVolunteers,
            'remark': trip.remark,
            'staffId': trip.staffId,
          }));
      Trip newTrip = Trip(
          tripId: json.decode(response.body)['name'],
          description: trip.description,
          tripDate: trip.tripDate,
          location: trip.location,
          crisisType: trip.crisisType,
          numVolunteers: trip.numVolunteers,
          staffId: trip.staffId);
      //Add to local array only if operation success
      if (response.statusCode == 200) {
        _staffTrip.add(newTrip);
        notifyListeners();
        return true;
      } else {
        print('addTrips() method failed');
      }
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<void> clearTripList() {
    _staffTrip = [];
  }
}

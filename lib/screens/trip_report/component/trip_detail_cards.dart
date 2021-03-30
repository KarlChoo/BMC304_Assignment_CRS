import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/providers/trip_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class TripDetailCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider>(context);
    final tripProvider = Provider.of<TripProvider>(context);
    final trip = Provider.of<Trip>(context);

    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 2.0,
      child: InkWell(
        onTap: (){
          //Go to extra details Page
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Trip ID: ${trip.tripId}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(width: getProportionateScreenWidth(10),),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Description: ${trip.description}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Trip Date: ${trip.tripDate}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Location: ${trip.location}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Disaster Type: ${trip.crisisType}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Participation Count: ${trip.applicationList.length} / ${trip.numVolunteers}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


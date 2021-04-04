import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:bmc304_assignment_crs/providers/trip_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';

class TripListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trip = Provider.of<Trip>(context);
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "${trip.tripId}",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
                Spacer(),

              ],
            ),
            Row(
              children: [
                Icon(Icons.dangerous,color: Colors.grey,size: 14,),
                SizedBox(width: getProportionateScreenWidth(5),),
                Expanded(
                  flex: 1,
                  child: Text(trip.crisisType,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.description,color: Colors.grey,size: 14),
                SizedBox(width: getProportionateScreenWidth(5),),
                Expanded(
                  child: Text(trip.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.date_range,color: Colors.grey,size: 14,),
                SizedBox(width: getProportionateScreenWidth(5),),
                Expanded(
                  child: Text(trip.tripDate,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Icon(Icons.perm_contact_cal_outlined,color: Colors.grey,size: 14,),
                SizedBox(width: getProportionateScreenWidth(5),),
                Expanded(
                  child: Text('${trip.availableNumVolunteers.toString()}/${trip.numVolunteers.toString()} Volunteers needed',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Icon(Icons.map_outlined,color: Colors.grey,size: 14,),
                SizedBox(width: getProportionateScreenWidth(5),),
                Expanded(
                  child: Text(trip.location,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bmc304_assignment_crs/components/staff_list_card.dart';
import 'package:bmc304_assignment_crs/components/trip_list_card.dart';
import 'package:bmc304_assignment_crs/models/staff.dart';
import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:bmc304_assignment_crs/providers/trip_provider.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController searchController = new TextEditingController();
  bool needReloadData = true;

  @override
  void didChangeDependencies() async {
    if (needReloadData) {
      Provider.of<TripProvider>(context).getAllTrips().then((value) {
        print('Trip data reloaded');
        needReloadData = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider> (context);
    var tripList = Provider.of<TripProvider>(context).getTripsByAdmin(staffProvider.currentStaff.id);


    Container buildSearchBar() {
      return Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: searchController,
          onChanged: (value) {
            // staffList = constStaffList;
            // searchFilterByName(value);
            // print(staffList);
            // print(constStaffList);
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(15)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "Search user...",
              prefixIcon: Icon(Icons.search)),
        ),
      );
    }

    Future<bool> _onWillPop() async {
      return (await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to logout'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                staffProvider.signoutStaff();
                Navigator.pushReplacementNamed(
                    context, SignInScreen.routeName);
              },
              child: Text('Yes'),
            ),
          ],
        ),
      )) ?? false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              buildSearchBar(),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: !needReloadData
                      ? tripList.length > 0
                      ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: tripList.length,
                      itemBuilder: (ctx, i) =>
                          ChangeNotifierProvider.value(
                            value: tripList[i],
                            child: Column(
                              children: [
                                TripListCard(),
                                SizedBox(
                                  height:
                                  getProportionateScreenHeight(10),
                                )
                              ],
                            ),
                          )
                  )
                      : Text("You have not registered any trip yet...")
                      : Column(
                    children: [
                      Text("Loading Data..."),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Image.asset(
                        "assets/images/circular_progress_indicator.gif",
                        width: getProportionateScreenWidth(100),
                        height: getProportionateScreenHeight(100),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );


  }
}

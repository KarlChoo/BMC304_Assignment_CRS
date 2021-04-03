import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:bmc304_assignment_crs/screens/sign_in/sign_in_screen.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_report/component/volunteer_list_card.dart';
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
      Provider.of<VolunteerProvider>(context).getAllVolunteers().then((value) {
        print('Volunteer data reloaded');
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


  Container buildSearchBar() {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) => print(value),
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
  @override
  Widget build(BuildContext context) {
    final volunteerProvider = Provider.of<VolunteerProvider>(context);
    var volunteerList = volunteerProvider.systemVolunteers;
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
                volunteerProvider.signoutVolunteer();
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
                        ? volunteerList.length > 0
                        ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: volunteerList.length,
                        itemBuilder: (ctx, i) =>
                            ChangeNotifierProvider.value(
                              value: volunteerList[i],
                              child: Column(
                                children: [
                                  VolunteerListCard(),
                                  SizedBox(
                                    height:
                                    getProportionateScreenHeight(
                                        10),
                                  )
                                ],
                              ),
                            ))
                        : Text("There are no volunteers in the system...")
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
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

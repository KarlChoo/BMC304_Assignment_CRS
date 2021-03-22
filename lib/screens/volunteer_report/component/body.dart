import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider>(context);
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
      )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Text("Volunteer report")
      ),
    );
  }
}

import 'package:bmc304_assignment_crs/constants.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_edit_profile/edit_profile_page.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_update_document/update_document_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/Profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, EditProfilePage.routeName);
                      },
                      style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                      child: Text('Edit Profile'))),
              SizedBox(
                height: 40,
              ),
              Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, UpdateDocumentPage.routeName);
                      },
                      style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                      child: Text('Update Documents'))),
            ],
          ),
        ),
      ),
    );
  }
}

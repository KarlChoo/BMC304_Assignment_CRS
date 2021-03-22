import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaffDetails extends StatefulWidget {
  @override
  _StaffDetailsState createState() => _StaffDetailsState();
}

class _StaffDetailsState extends State<StaffDetails> {
  final kStaffLabelText = TextStyle(fontSize: 12, color: Colors.blueAccent);
  final kStaffDetailText = TextStyle(fontSize: 16);

  bool hidePassword = true;
  String passwordHash;

  void generatePasswordHash(String password) {
    passwordHash = "*" * password.length;
  }

  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider>(context);
    staffProvider.updateOwnDetails();
    var staff = staffProvider.currentStaff;
    generatePasswordHash(staffProvider.currentStaff.password);
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Username",
              style: kStaffLabelText,
            ),
            Text(
              staff.username,
              style: kStaffDetailText,
              overflow: TextOverflow.visible,
            )
          ],
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Password",
              style: kStaffLabelText,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hidePassword ? passwordHash : staff.password,
                  style: kStaffDetailText,
                  overflow: TextOverflow.visible,
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    child: Icon(
                      hidePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 24,
                    )
                ),
              ],
            )
          ],
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email", style: kStaffLabelText),
            Text(
              staff.email,
              style: kStaffDetailText,
              overflow: TextOverflow.visible,
            )
          ],
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Phone", style: kStaffLabelText),
            Text(
              staff.phone,
              style: kStaffDetailText,
              overflow: TextOverflow.visible,
            )
          ],
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Address", style: kStaffLabelText),
            Text(
              staff.address,
              style: kStaffDetailText,
              overflow: TextOverflow.visible,
            )
          ],
        ),
        Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date Joined", style: kStaffLabelText),
            Text(
              formatDate(DateTime.fromMicrosecondsSinceEpoch(staff.dateJoined),
                  [dd, " ", MM, " ", yyyy]),
              style: kStaffDetailText,
              overflow: TextOverflow.visible,
            ),
          ],
        ),
      ],
    );
  }
}

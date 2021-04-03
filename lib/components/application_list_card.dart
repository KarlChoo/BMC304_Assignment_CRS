import 'package:bmc304_assignment_crs/models/application.dart';
import 'package:bmc304_assignment_crs/models/staff.dart';
import 'package:bmc304_assignment_crs/providers/application_provider.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/screens/staff_edit_page/staff_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';

class ApplicationListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final application = Provider.of<Application>(context);
    final applicationProvider = Provider.of<ApplicationProvider>(context);

    buildTitle() {

      print("buildTitle test");
      List<Expanded> titleList = [];
      Expanded title = Expanded(
        flex: 4,
        child: Text(
          "Volunteer ID:${application.volunteerId}",
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
          overflow: TextOverflow.visible,
        ),
      );

      Expanded action = Expanded(
        flex: 1,
        child: PopupMenuButton(
          tooltip: "More actions",
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(Icons.done_outlined),
                  SizedBox(width: getProportionateScreenWidth(10),),
                  Text("Accept")
                ],
              ),
              value: "accept",
              textStyle: TextStyle(fontSize: 14, color: Colors.black),
            ),
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(Icons.close_outlined),
                  Spacer(),
                  Text("Reject")
                ],
              ),
              value: "reject",
              textStyle: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
          onSelected: (value) async{

            String snackBarMsg = "";
            if (value == "accept"){
              final result = await applicationProvider.updateStatus(application, "Accepted");
              if (result)
                snackBarMsg = "Application has been accepted";
              else
                snackBarMsg = "Application acceptance failed";
            }
            else{
              final result = await applicationProvider.updateStatus(application, "Rejected");
              if (result)
                snackBarMsg = "Application has been rejected";
              else
                snackBarMsg = "Application rejection failed";

            }
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    snackBarMsg,
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "Ok",
                    onPressed: () {  },
                  ),
                  behavior: SnackBarBehavior.fixed,
                )
            );
          },
        ),
      );

      titleList.add(title);
      print (application.status);
      print (applicationProvider.applicationList.length);
      if (application.status=="New")
        titleList.add(action);

      return titleList;


    }
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
          children: [
            Row(
              children: buildTitle(),
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Application ID: ${application.tripId}",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.date_range_outlined,color: Colors.grey,size: 14),
                SizedBox(width: getProportionateScreenWidth(5),),
                Expanded(
                  child: Text(application.applicationDate,
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
                Icon(Icons.question_answer_outlined,color: Colors.grey,size: 14,),
                SizedBox(width: getProportionateScreenWidth(5),),
                Expanded(
                  child: Text(application.status,
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
                Icon(Icons.description,color: Colors.grey,size: 14,),
                SizedBox(width: getProportionateScreenWidth(5),),
                Expanded(
                  child: Text(application.description,
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

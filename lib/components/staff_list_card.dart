import 'package:bmc304_assignment_crs/models/staff.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/screens/manager_edit_staff/manager_edit_admin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';

class StaffListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider>(context);
    final staff = Provider.of<Staff>(context);
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
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black,
                  backgroundImage: AssetImage("assets/images/profile-icon-png-910.png"),
                ),
                SizedBox(width: getProportionateScreenWidth(10),),
                Expanded(
                  flex: 4,
                  child: Text(
                    "${staff.firstName} ${staff.lastName}",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 1,
                  child: PopupMenuButton(
                    tooltip: "More actions",
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: getProportionateScreenWidth(10),),
                            Text("Edit")
                          ],
                        ),
                        value: "edit",
                        textStyle: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.stop_circle_outlined),
                            Spacer(),
                            Text(staff.suspended ? "Unban" : "Suspend")
                          ],
                        ),
                        value: "suspend",
                        textStyle: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            SizedBox(width: getProportionateScreenWidth(10),),
                            Text("Delete")
                          ],
                        ),
                        value: "delete",
                        textStyle: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                    onSelected: (value) async{
                      print('value');
                      if(staff.position == "Director") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Director account cannot be modified by a manager",
                              ),
                              duration: Duration(seconds: 2),
                              action: SnackBarAction(
                                label: "Ok",
                                onPressed: () {  },
                              ),
                              behavior: SnackBarBehavior.fixed,
                            )
                        );
                        return;
                      }
                      switch(value) {
                        case "edit":
                          Navigator.pushNamed(context, ManagerEditStaff.routeName, arguments: staff);
                          break;
                        case "suspend":
                          final result = await staffProvider.suspendStaff(staff);

                          String snackBarMsg = "";
                          if(result) {
                            if(staff.suspended)
                              snackBarMsg = "User ${staff.firstName} ${staff.lastName} has been suspended";
                            else
                              snackBarMsg = "User ${staff.firstName} ${staff.lastName} has been unbanned";
                          }
                          else {
                            if(staff.suspended)
                              snackBarMsg = "Unban of staff failed due to backend error";
                            else
                              snackBarMsg = "Suspension of staff failed due to backend error";
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
                          break;
                        case "delete":
                          final result = await staffProvider.deleteStaff(staff.id);

                          String snackBarMsg = "";
                          if(result) snackBarMsg = "User ${staff.firstName} ${staff.lastName} has been deleted";
                          else snackBarMsg = "Deletion of staff failed due to backend error";

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
                          break;
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.person,color: Colors.grey,size: 14,),
                SizedBox(width: getProportionateScreenWidth(5),),
                Expanded(
                  flex: 1,
                  child: Text(staff.username,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Chip(
                      padding: EdgeInsets.zero,
                      backgroundColor: staff.suspended ? Colors.red : Colors.green,
                      label: Text(
                        staff.suspended ? "Suspended" : "Operational",
                        style: TextStyle(fontSize: 10),
                      ),
                    )
                )
              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.phone,color: Colors.grey,size: 14),
                SizedBox(width: getProportionateScreenWidth(5),),
                Expanded(
                  child: Text(staff.phone,
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
                Icon(Icons.email,color: Colors.grey,size: 14,),
                SizedBox(width: getProportionateScreenWidth(5),),
                Expanded(
                  child: Text(staff.email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

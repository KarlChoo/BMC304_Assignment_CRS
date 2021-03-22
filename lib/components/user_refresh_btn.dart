import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserRefreshButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider>(context);
    return IconButton(
      icon: Icon(Icons.refresh,color: Colors.white,size: 30,),
      onPressed: () async{
        await staffProvider.getAllSystemStaff();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Admin data has been refreshed",
              ),
              duration: Duration(seconds: 2),
              action: SnackBarAction(
                label: "Ok",
                onPressed: () {  },
              ),
              behavior: SnackBarBehavior.fixed,
            )
        );
      }
    );
  }
}

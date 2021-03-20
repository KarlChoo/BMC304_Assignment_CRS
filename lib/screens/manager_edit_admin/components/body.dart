import 'dart:math';

import 'package:bmc304_assignment_crs/components/custom_surfix_icon.dart';
import 'package:bmc304_assignment_crs/components/default_button.dart';
import 'package:bmc304_assignment_crs/constants.dart';
import 'package:bmc304_assignment_crs/helper/keyboard.dart';
import 'package:bmc304_assignment_crs/models/staff.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/size_config.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = new TextEditingController();
  String username;
  final passwordController = new TextEditingController();
  String password;
  final firstNameController = new TextEditingController();
  String firstName;
  final lastNameController = new TextEditingController();
  String lastName;
  final emailController = new TextEditingController();
  String email;
  final addressController = new TextEditingController();
  String address;
  final phoneController = new TextEditingController();
  String phone;
  final dateController = new TextEditingController();
  DateTime joinedDateTime;
  String dateTimeString;

  showDate() async{
    final DateTime newDate = await showDatePicker(
        context: context,
        initialDate: joinedDateTime == null ? DateTime.now() : joinedDateTime,
        firstDate: DateTime(2010,1,1),
        lastDate: DateTime.now()
    );

    setState(() {
      if(newDate != null) {
        joinedDateTime = newDate;
        dateTimeString = formatDate(
            newDate,
            [dd, "-", mm, "-", yyyy]
        );
        print(joinedDateTime);
        print(dateTimeString);
        dateController.text = dateTimeString;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final staffProvider = Provider.of<StaffProvider>(context);
    Staff admin = ModalRoute.of(context).settings.arguments;
    usernameController.text = admin.username ;
    passwordController.text = admin.password;
    firstNameController.text = admin.firstName;
    lastNameController.text = admin.lastName;
    emailController.text = admin.email;
    addressController.text = admin.address;
    phoneController.text = admin.phone;
    joinedDateTime = DateTime.fromMicrosecondsSinceEpoch(admin.dateJoined);
    dateController.text = formatDate(DateTime.fromMicrosecondsSinceEpoch(admin.dateJoined), [dd,"-",mm,"-",yyyy]);

    return SafeArea(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          KeyboardUtil.hideKeyboard(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 36, bottom: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            buildUsernameField(),
                            SizedBox(height: getProportionateScreenHeight(15),),
                            buildPasswordField(),
                            SizedBox(height: getProportionateScreenHeight(15),),
                            buildFirstNameField(),
                            SizedBox(height: getProportionateScreenHeight(15),),
                            buildLastNameField(),
                            SizedBox(height: getProportionateScreenHeight(15),),
                            buildEmailField(),
                            SizedBox(height: getProportionateScreenHeight(15),),
                            buildAddressField(),
                            SizedBox(height: getProportionateScreenHeight(15),),
                            buildPhoneField(),
                            SizedBox(height: getProportionateScreenHeight(15),),
                            buildDateField(),
                          ]
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15),),
              DefaultButton(
                text: "Edit Details",
                press: () async{
                  KeyboardUtil.hideKeyboard(context);
                  if(_formKey.currentState.validate()){
                    _formKey.currentState.save();

                    // Validation for username being used
                    // final userExists = await staffProvider.isUserExist(username);
                    // if(userExists) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         content: Text(
                    //           "Username is already taken",
                    //         ),
                    //         duration: Duration(seconds: 2),
                    //         action: SnackBarAction(
                    //           label: "Ok",
                    //           onPressed: () {  },
                    //         ),
                    //         behavior: SnackBarBehavior.fixed,
                    //       )
                    //   );
                    //   return;
                    // }

                    Staff newStaff = new Staff(
                        id: admin.id,
                        username: username,
                        password: password,
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        phone: phone,
                        address: address,
                        position: "Admin",
                        suspended: false,
                        dateJoined: joinedDateTime.microsecondsSinceEpoch
                    );

                    final result = await staffProvider.updateStaff(newStaff);

                    String snackBarMsg = "";
                    if(result) snackBarMsg = "Admin details updated";
                    else snackBarMsg = "Failed to update admin details due to backend issues";
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
                    if(result) Navigator.pop(context);
                  }
                },
              )
            ]
          ),
        ),
      )
    );
  }

  TextFormField buildUsernameField() {
    return TextFormField(
      focusNode: FocusNode(
        canRequestFocus: false
      ),
      style: TextStyle(
        color: Colors.grey,
      ),
      readOnly: true,
      controller: usernameController,
      keyboardType: TextInputType.text,
      onChanged: (newValue) => username = newValue,
      onSaved: (newValue) => username = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return kNoEmptyError;
        }
        return null;
      },
      decoration: InputDecoration(
        isCollapsed: true,
        errorStyle: TextStyle(fontSize: 12,height: 1),
        labelText: "Username",
        hintText: "Enter your username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      onChanged: (newValue) => password = newValue,
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return kNoEmptyError;
        }
        if(value.length < 8){
          return "Password must be at least 8 characters";
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 12,height: 1),
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildFirstNameField() {
    return TextFormField(
      maxLength: 50,
      controller: firstNameController,
      keyboardType: TextInputType.text,
      onChanged: (newValue) => firstName = newValue,
      onSaved: (newValue) => firstName = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return kNoEmptyError;
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 12,height: 1),
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.account_circle_outlined),
        ),
      ),
    );
  }

  TextFormField buildLastNameField() {
    return TextFormField(
      maxLength: 50,
      controller: lastNameController,
      keyboardType: TextInputType.text,
      onChanged: (newValue) => lastName = newValue,
      onSaved: (newValue) => lastName = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return kNoEmptyError;
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 12,height: 1),
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.account_circle_outlined),
        ),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      maxLength: 62,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onChanged: (newValue) => email = newValue,
      onSaved: (newValue) => email = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return kNoEmptyError;
        }
        if(!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 12,height: 1),
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.email),
        ),
      ),
    );
  }

  TextFormField buildAddressField() {
    return TextFormField(
      minLines: 4,
      maxLines: 4,
      controller: addressController,
      keyboardType: TextInputType.text,
      onChanged: (newValue) => address = newValue,
      onSaved: (newValue) => address = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return kNoEmptyError;
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 12,height: 1),
        labelText: "Address",
        hintText: "Enter your address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.location_on_outlined),
        ),
      ),
    );
  }

  TextFormField buildPhoneField() {
    return TextFormField(
      maxLength: 15,
      controller: phoneController,
      keyboardType: TextInputType.phone,
      onChanged: (newValue) => phone = newValue,
      onSaved: (newValue) => phone = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return kNoEmptyError;
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 12,height: 1),
        labelText: "Phone",
        hintText: "Enter your phone",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  Row buildDateField() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: TextFormField(
            controller: dateController,
            keyboardType: TextInputType.datetime,
            readOnly: true,
            //onSaved: (newValue) => dateTime = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return kNoEmptyError;
              }
              return null;
            },
            decoration: InputDecoration(
              errorStyle: TextStyle(fontSize: 12,height: 1),
              labelText: "Joined Date",
              hintText: "Select a date",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Padding(
                padding: EdgeInsets.zero,
                child: IconButton(
                  icon: Icon(Icons.cancel),
                  color: Colors.grey,
                  onPressed: () {
                    if(joinedDateTime != null) {
                      dateController.text = "";
                      joinedDateTime = null;
                    }
                  },
                ),
              ),
            ),
          )
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(Icons.calendar_today),
            splashColor: Colors.black,
            splashRadius: 25,
            color: kPrimaryColor,
            onPressed: (){
              KeyboardUtil.hideKeyboard(context);
              showDate();
            },
          )
        )
      ],
    );
  }
}

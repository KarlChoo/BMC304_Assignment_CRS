import 'package:bmc304_assignment_crs/components/default_button.dart';
import 'package:bmc304_assignment_crs/constants.dart';
import 'package:bmc304_assignment_crs/helper/keyboard.dart';
import 'package:bmc304_assignment_crs/models/trip.dart';
import 'package:bmc304_assignment_crs/providers/trip_provider.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:bmc304_assignment_crs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final _formKey = GlobalKey<FormState>();
  //crisisType
  //description
  //location
  //numVolunteers
  //tripDate
  //staffId
  final descriptionController = new TextEditingController();
  final locationController = new TextEditingController();
  final numVolunteersController = new TextEditingController();
  final tripDateController = new TextEditingController();
  String crisisType ='Flood';
  String description;
  String location;
  int numVolunteers;
  DateTime tripDate;
  String tripDateString;
  String staffId;

  bool disableBtn = false;

  showDate() async {
    final DateTime newDate = await showDatePicker(
        context: context,
        initialDate: tripDate == null ? DateTime.now() : tripDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));

    if (newDate != null) {
      tripDate = newDate;
      tripDateString = formatDate(newDate, [dd, "-", mm, "-", yyyy]);
      tripDateController.text = tripDateString;
    }
  }

  @override
  void dispose() {
    descriptionController.dispose();
    locationController.dispose();
    numVolunteersController.dispose();
    tripDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context);
    final staffProvider = Provider.of<StaffProvider>(context);
    return SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            KeyboardUtil.hideKeyboard(context);
          },
          child: Padding(
            padding:
            const EdgeInsets.only(left: 20, right: 20, top: 36, bottom: 10),
            child: Column(children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(children: [
                          buildCrisisType(),
                          SizedBox(
                          height: getProportionateScreenHeight(15),
                          ),
                          buildDescription(),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          buildLocation(),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          buildNumVolunteers(),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          buildTripDate(),
                        ]),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              DefaultButton(
                text: "Register",
                press: () async {
                  KeyboardUtil.hideKeyboard(context);

                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    if(disableBtn) return;
                    disableBtn = true;
                    Trip newTrip = new Trip(
                      crisisType: crisisType,
                      description: description,
                      location: location,
                      numVolunteers: numVolunteers,
                      tripDate: formatter.format(tripDate),
                      staffId: staffProvider.currentStaff.id
                    );
                    final result = await tripProvider.addTrip(newTrip);
                    disableBtn = false;
                    String snackBarMsg = "";
                    if (result)
                      snackBarMsg = "New Trip Registered";
                    else
                      snackBarMsg = "Failed to register new trip";
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        snackBarMsg,
                      ),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: "Ok",
                        onPressed: () {},
                      ),
                      behavior: SnackBarBehavior.fixed,
                    ));
                    if (result) {
                      Navigator.pop(context);
                    }
                  }
                },
              )
            ]),
          ),
        ));
  }

  DropdownButton buildCrisisType() {
    return DropdownButton<String>(
      value: crisisType,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
      ),
      underline: Container(
        height: 2,
      ),
      onChanged: (String newValue) {
        print(newValue);
        setState(() {
          crisisType = newValue;
        });
      },
      items: <String>['Flood', 'Earthquake', 'Wildfire', 'Others']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
          .toList(),

    );
  }

  TextFormField buildDescription() {
    return TextFormField(
      minLines: 4,
      maxLines: 4,
      controller: descriptionController,
      keyboardType: TextInputType.text,
      onChanged: (newValue) => description = newValue,
      onSaved: (newValue) => description = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return kNoEmptyError;
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 12, height: 1),
        labelText: "Description",
        hintText: "Enter your description",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.location_on_outlined),
        ),
      ),
    );
  }

  TextFormField buildLocation (){
    return TextFormField(
      maxLength: 50,
      controller: locationController,
      keyboardType: TextInputType.text,
      onChanged: (newValue) => location = newValue,
      onSaved: (newValue) => location = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return kNoEmptyError;
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 12, height: 1),
        labelText: "Location",
        hintText: "Enter your location",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.account_circle_outlined),
        ),
      ),
    );
  }

  TextFormField buildNumVolunteers (){
    return TextFormField(
      maxLength: 50,
      controller: numVolunteersController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ], // Only numbers can be en
      onChanged: (newValue) => numVolunteers = int.parse(newValue),
      onSaved: (newValue) => numVolunteers = int.parse(newValue),
      validator: (value) {
        if (value.isEmpty) {
          return kNoEmptyError;
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 12, height: 1),
        labelText: "Number of Volunteers",
        hintText: "Enter your number of volunteers",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.account_circle_outlined),
        ),
      ),
    );
  }

  Row buildTripDate (){
    return Row(
      children: [
        Expanded(
            flex: 5,
            child: TextFormField(
              controller: tripDateController,
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
                errorStyle: TextStyle(fontSize: 12, height: 1),
                labelText: "Trip Date",
                hintText: "Select a date",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Padding(
                  padding: EdgeInsets.zero,
                  child: IconButton(
                    icon: Icon(Icons.cancel),
                    color: Colors.grey,
                    onPressed: () {
                      if (tripDate != null) {
                        tripDateController.text = "";
                        tripDate = null;
                      }
                    },
                  ),
                ),
              ),
            )),
        Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.calendar_today),
              splashColor: Colors.black,
              splashRadius: 25,
              color: kPrimaryColor,
              onPressed: () {
                KeyboardUtil.hideKeyboard(context);
                showDate();
              },
            ))
      ],
    );
  }

  // sample below to be deleted
  /*
  TextFormField buildUsernameField() {
    return TextFormField(
      maxLength: 45,
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
        errorStyle: TextStyle(fontSize: 12, height: 1),
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
        if (value.length < 8) {
          return "Password must be at least 8 characters";
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 12, height: 1),
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
        errorStyle: TextStyle(fontSize: 12, height: 1),
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
        errorStyle: TextStyle(fontSize: 12, height: 1),
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
        if (!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 12, height: 1),
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
        errorStyle: TextStyle(fontSize: 12, height: 1),
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
        errorStyle: TextStyle(fontSize: 12, height: 1),
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
                errorStyle: TextStyle(fontSize: 12, height: 1),
                labelText: "Joined Date",
                hintText: "Select a date",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Padding(
                  padding: EdgeInsets.zero,
                  child: IconButton(
                    icon: Icon(Icons.cancel),
                    color: Colors.grey,
                    onPressed: () {
                      if (joinedDateTime != null) {
                        dateController.text = "";
                        joinedDateTime = null;
                      }
                    },
                  ),
                ),
              ),
            )),
        Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.calendar_today),
              splashColor: Colors.black,
              splashRadius: 25,
              color: kPrimaryColor,
              onPressed: () {
                KeyboardUtil.hideKeyboard(context);
                showDate();
              },
            ))
      ],
    );
  }
  */
}

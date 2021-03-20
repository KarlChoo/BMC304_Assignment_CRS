import 'package:bmc304_assignment_crs/providers/volunteer_provider.dart';
import 'package:bmc304_assignment_crs/providers/staff_provider.dart';
import 'package:flutter/material.dart';
import 'package:bmc304_assignment_crs/components/custom_surfix_icon.dart';
import 'package:bmc304_assignment_crs/components/form_error.dart';
import 'package:bmc304_assignment_crs/helper/keyboard.dart';
import 'package:bmc304_assignment_crs/screens/forgot_password/forgot_password_screen.dart';
import 'package:bmc304_assignment_crs/screens/login_success/login_success_screen.dart';
import 'package:provider/provider.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String username;
  String password;
  bool remember = false;
  final List<String> errors = [];

  var _type = [
    'Staff',
    'Volunteer',
  ];

  String _typeSelected;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    StaffProvider staffProvider = Provider.of<StaffProvider>(context);
    VolunteerProvider volunteerProvider = Provider.of<VolunteerProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUsernameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              isExpanded: true,
              hint: Text(
                'Select Your Account Type',
                style: TextStyle(fontSize: 16),
              ),
              items: _type.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(
                    dropDownStringItem,
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    KeyboardUtil.hideKeyboard(context);
                  },
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                setState(() {
                  _typeSelected = newValueSelected;
                });
              },
              value: _typeSelected,
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Log In",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                if (_typeSelected == 'Staff') {
                  final response = await staffProvider.login(
                      usernameController.text, passwordController.text);
                  if (response == 0) {
                    //Login successful
                    Navigator.pushReplacementNamed(context, LoginSuccessScreen.routeName);
                    usernameController.text = '';
                    passwordController.text = '';
                  } else if (response == 1) {
                    //Login failed
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Wrong Username or Password!'),
                      duration: Duration(seconds: 2),
                    ));
                  } else if (response == 2) {
                    //Suspended
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Account has been suspended'),
                      duration: Duration(seconds: 2),
                    ));
                  }
                }else if (_typeSelected == 'Volunteer') {
                  final response = await volunteerProvider.login(
                      usernameController.text, passwordController.text);
                  if (response != null) {
                    Navigator.pushReplacementNamed(context, LoginSuccessScreen.routeName);
                    usernameController.text = '';
                    passwordController.text = '';
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Wrong Username or Password!'),
                      duration: Duration(seconds: 2),
                    ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please select the account type to login!'),
                    duration: Duration(seconds: 2),
                  ));
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    //passwordController.text = 'admin123456';
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        errorStyle: TextStyle(height: 0),
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      controller: usernameController,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Username",
        errorStyle: TextStyle(height: 0),
        hintText: "Enter your username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}

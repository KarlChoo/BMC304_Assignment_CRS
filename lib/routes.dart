import 'package:bmc304_assignment_crs/screens/edit_profile/edit_profile_page.dart';
import 'package:bmc304_assignment_crs/screens/profile_option_page/profile_screen.dart';
import 'package:bmc304_assignment_crs/screens/profile_page/profile_screen.dart';
import 'package:bmc304_assignment_crs/screens/update_document/update_document_page.dart';
import 'package:flutter/widgets.dart';
import 'package:bmc304_assignment_crs/screens/cart/cart_screen.dart';
import 'package:bmc304_assignment_crs/screens/complete_profile/complete_profile_screen.dart';
import 'package:bmc304_assignment_crs/screens/details/details_screen.dart';
import 'package:bmc304_assignment_crs/screens/forgot_password/forgot_password_screen.dart';
import 'package:bmc304_assignment_crs/screens/home/home_screen.dart';
import 'package:bmc304_assignment_crs/screens/login_success/login_success_screen.dart';
import 'package:bmc304_assignment_crs/screens/otp/otp_screen.dart';
import 'package:bmc304_assignment_crs/screens/sign_in/sign_in_screen.dart';
import 'package:bmc304_assignment_crs/screens/splash/splash_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ProfilePage.routeName: (context) => ProfilePage(),
  EditProfilePage.routeName: (context) => EditProfilePage(),
  UpdateDocumentPage.routeName: (context) => UpdateDocumentPage(),
};

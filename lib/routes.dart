import 'package:bmc304_assignment_crs/screens/manager_add_staff/manager_add_staff.dart';
import 'package:bmc304_assignment_crs/screens/manager_edit_staff/manager_edit_admin.dart';
import 'package:bmc304_assignment_crs/screens/manager_home/manager_home.dart';
import 'package:bmc304_assignment_crs/screens/manager_manage_admin/manager_manage_admin.dart';
import 'package:bmc304_assignment_crs/screens/manager_manage_staffs/manager_manage_staffs.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_application/all_application_page.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_application/volunteer_application_status_page.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_edit_profile/edit_profile_page.dart';
import 'package:bmc304_assignment_crs/screens/profile_option_page/profile_screen.dart';
import 'package:bmc304_assignment_crs/screens/profile_page/profile_screen.dart';
import 'package:bmc304_assignment_crs/screens/trip_report/trip_report.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_report/volunteer_report.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_trips_application/trips_application_page.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_update_document/update_document_page.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_update_document/upload_images_page.dart';
import 'package:flutter/widgets.dart';
import 'package:bmc304_assignment_crs/screens/cart/cart_screen.dart';
import 'package:bmc304_assignment_crs/screens/complete_profile/complete_profile_screen.dart';
import 'package:bmc304_assignment_crs/screens/details/details_screen.dart';
import 'package:bmc304_assignment_crs/screens/forgot_password/forgot_password_screen.dart';
import 'package:bmc304_assignment_crs/screens/volunteer_home/home_screen.dart';
import 'package:bmc304_assignment_crs/screens/login_success/login_success_screen.dart';
import 'package:bmc304_assignment_crs/screens/otp/otp_screen.dart';
import 'package:bmc304_assignment_crs/screens/sign_in/sign_in_screen.dart';
import 'package:bmc304_assignment_crs/screens/splash/splash_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

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
  ManagerHome.routeName: (context) => ManagerHome(),
  ManagerManageAdmin.routeName: (context) => ManagerManageAdmin(),
  ManagerManageStaff.routeName: (context) => ManagerManageStaff(),
  ManagerAddStaff.routeName: (context) => ManagerAddStaff(),
  ManagerEditStaff.routeName: (context) => ManagerEditStaff(),
  ProfilePage.routeName: (context) => ProfilePage(),
  EditProfilePage.routeName: (context) => EditProfilePage(),
  UpdateDocumentPage.routeName: (context) => UpdateDocumentPage(),
  TripReport.routeName: (context) => TripReport(),
  VolunteerReport.routeName: (context) => VolunteerReport(),
  UploadImagePage.routeName: (context) => UploadImagePage(),
  TripsApplication.routeName: (context) => TripsApplication(),
  ApplicationStatus.routeName: (context) => ApplicationStatus(),
  AllApplication.routeName: (context) => AllApplication(),
};

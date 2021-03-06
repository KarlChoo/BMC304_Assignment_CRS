import 'package:bmc304_assignment_crs/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:bmc304_assignment_crs/routes.dart';
import 'package:bmc304_assignment_crs/screens/splash/splash_screen.dart';
import 'package:bmc304_assignment_crs/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(),
        // home: SplashScreen(),
        // We use routeName so that we dont need to remember the name
        initialRoute: SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}

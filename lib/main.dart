import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './models/sharedPrefs.dart';
import './screens/admin_screen.dart';

import './screens/user_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

final sharedPrefs = SharedPrefs();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                fontFamily: 'Raleway',
                primarySwatch: Colors.deepPurple,
                canvasColor: Color.fromRGBO(10, 5, 27, 0.9),
              ),
              home: appSnapshot.connectionState != ConnectionState.done
                  ? SplashScreen()
                  : StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (ctx, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SplashScreen();
                        }
                        if (userSnapshot.hasData) {
                          if (sharedPrefs.adminStatus == null)
                            return UserScreen();
                          else if (sharedPrefs.adminStatus)
                            return AdminScreen();
                          else
                            return UserScreen();
                        }
                        return AuthScreen();
                      }),
              routes: {
                SplashScreen.routeName: (ctx) => SplashScreen(),
              });
        });
  }
}
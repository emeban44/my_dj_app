import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_dj_app/screens/admin/create_lobby_screen.dart';
import 'package:provider/provider.dart';
import './screens/admin/add_song_screen.dart';
import './models/sharedPrefs.dart';
import './screens/admin_screen.dart';

import './screens/user_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';
import 'providers/songs_provider.dart';

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
          return ChangeNotifierProvider(
            create: (ctx) => Songs(),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  fontFamily: 'Raleway',
                  primarySwatch: Colors.deepPurple,
                  accentColor: Colors.pink.shade100,
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
                  AddSongScreen.routeName: (ctx) => AddSongScreen(),
                  CreateLobbyScreen.routeName: (ctx) => CreateLobbyScreen(),
                }),
          );
        });
  }
}

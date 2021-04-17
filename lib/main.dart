import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_dj_app/providers/lobbies_provider.dart';
import 'package:my_dj_app/providers/timer_provider.dart';
import 'package:my_dj_app/screens/admin/create_lobby_screen.dart';
import 'package:my_dj_app/screens/user/user_start_screen.dart';
import 'package:provider/provider.dart';
import './screens/admin/add_song_screen.dart';
import './models/sharedPrefs.dart';
import './screens/admin_screen.dart';

import './screens/user_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';
import 'providers/poll_provider.dart';
import 'providers/songs_provider.dart';
import 'providers/users_provider.dart';

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
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (ctx) => Songs(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => Lobbies(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => LobbyTimer(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => Polls(),
              ),
              ChangeNotifierProvider(
                create: (ctx) => Users(),
              ),
            ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'MyDJ App',
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
                              return UserStartScreen();
                            else if (sharedPrefs.adminStatus)
                              return AdminScreen();
                            else
                              return UserStartScreen();
                          }
                          //       Navigator.of(context).pop();
                          return AuthScreen();
                        }),
                routes: {
                  SplashScreen.routeName: (ctx) => SplashScreen(),
                  AddSongScreen.routeName: (ctx) => AddSongScreen(),
                  CreateLobbyScreen.routeName: (ctx) => CreateLobbyScreen(),
                  UserScreen.routeName: (ctx) => UserScreen(),
                  AuthScreen.routeName: (ctx) => AuthScreen(),
                }),
          );
        });
  }
}

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_dj_app/models/sharedPrefs.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(child: Text("WELCOME USER!!!!")),
          ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text('LOGOUT MATE')),
          Text(SharedPrefs().adminStatus.toString()),
        ],
      ),
    );
  }
}

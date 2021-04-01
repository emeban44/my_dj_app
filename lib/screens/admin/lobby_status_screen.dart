import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LobbyStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: Text('LOGOUT MATE')),
    );
  }
}

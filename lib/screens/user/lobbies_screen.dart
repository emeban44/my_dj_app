import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LobbiesScreen extends StatefulWidget {
  @override
  _LobbiesScreenState createState() => _LobbiesScreenState();
}

class _LobbiesScreenState extends State<LobbiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        child: Text('Log out for now'),
      ),
    );
  }
}

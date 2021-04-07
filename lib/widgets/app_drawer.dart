import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: Icon(Icons.logout),
                  label: Text('Logout')),
            ),
          ],
        ),
      ),
    );
  }
}

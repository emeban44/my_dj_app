import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_dj_app/screens/auth_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
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

                      /*    Navigator.of(context)
                          .pushReplacementNamed(AuthScreen.routeName); */
                    },
                    icon: Icon(Icons.logout),
                    label: Text('Logout')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

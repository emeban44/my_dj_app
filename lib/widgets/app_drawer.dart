import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_dj_app/models/sharedPrefs.dart';
import 'package:my_dj_app/providers/lobbies_provider.dart';
import 'package:my_dj_app/providers/users_provider.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final String _currentPage;
  final BuildContext contextOf;
  AppDrawer(
    this._currentPage,
    this.contextOf,
  );
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
                    onPressed: _currentPage == 'LobbyEntered'
                        ? () {
                            Provider.of<Users>(context, listen: false)
                                .removeUserFromLobby(
                                    SharedPrefs().userId,
                                    Provider.of<Lobbies>(context, listen: false)
                                        .getLobbyCode,
                                    contextOf,
                                    context);
                          }
                        : () {
                            FirebaseAuth.instance.signOut();
                            /*    Navigator.of(context)
                          .pushReplacementNamed(AuthScreen.routeName); */
                          },
                    icon: Icon(Icons.logout),
                    label: _currentPage == 'LobbyEntered'
                        ? Text('Leave Lobby')
                        : Text('Logout')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:my_dj_app/models/song.dart';
import 'package:my_dj_app/providers/songs_provider.dart';
import 'package:provider/provider.dart';

class LobbyStatusScreen extends StatefulWidget {
  @override
  _LobbyStatusScreenState createState() => _LobbyStatusScreenState();
}

class _LobbyStatusScreenState extends State<LobbyStatusScreen> {
  bool _lobbyCreated = false;

  @override
  Widget build(BuildContext context) {
    return !_lobbyCreated
        ? Center(
            child: Container(
              height: 75,
              width: 200,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    primary: Colors.pink,
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.library_add),
                  label: Text('CREATE A LOBBY')),
            ),
          )
        : Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Text(
                  'Number of users currently: ',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                )
              ],
            ),
          );
  }
}

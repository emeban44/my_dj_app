import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_dj_app/models/lobby.dart';
import 'package:my_dj_app/providers/timer_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_countdown_timer/index.dart';

import 'package:my_dj_app/models/song.dart';
import 'package:my_dj_app/providers/songs_provider.dart';
import 'package:my_dj_app/providers/lobbies_provider.dart';
import 'package:my_dj_app/screens/admin/create_lobby_screen.dart';

class LobbyStatusScreen extends StatefulWidget {
  @override
  _LobbyStatusScreenState createState() => _LobbyStatusScreenState();
}

class _LobbyStatusScreenState extends State<LobbyStatusScreen> {
  bool _lobbyCreated = false;
  int timeRemaining = 0;
  //CountdownTimerController _timerController;
  //

  void timer() {
    Provider.of<LobbyTimer>(context, listen: false).timer();
  }

  @override
  Widget build(BuildContext context) {
    Lobby currentLobby = Provider.of<Lobbies>(context).getCurrentLobby;
    return currentLobby.name == 'Non-existent'
        ? Center(
            child: Container(
              height: 75,
              width: 200,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    primary: Colors.pink,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(CreateLobbyScreen.routeName);
                  },
                  icon: Icon(Icons.library_add),
                  label: Text('CREATE A LOBBY')),
            ),
          )
        : Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      currentLobby.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(3.5, 2.0),
                            blurRadius: 1.0,
                          ),
                        ],
                        fontFamily: 'Doctor',
                        fontSize: 26,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.black,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      currentLobby.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(3.5, 2.0),
                            blurRadius: 1.0,
                          ),
                        ],
                        fontSize: 26,
                        fontFamily: 'Doctor',
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                Consumer<LobbyTimer>(
                    builder: (context, timeData, child) =>
                        Text(timeData.timeLeft.toString())),
                ElevatedButton(onPressed: timer, child: Text('click')),
                /* Text(timeRemaining.toString()),
                
                CountdownTimer(
                  endTime: ,
                  controller: widget._timerController,
                  widgetBuilder: (ctx, timeRemaining) {
                    if (timeRemaining == null) return Text('END');

                    return Text(
                      timeRemaining.sec.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Lexend',
                      ),
                    );
                  },
                ),
                Text(
                  currentLobby.name,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.pink, // Colors.grey.shade300,
                    fontFamily: 'Doctor',
                    decoration: TextDecoration.underline,

                    letterSpacing: 1,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(3.5, 2.0),
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                ),
                
                Text(
                  'Number of users currently: ',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                ),*/
              ],
            ),
          );
  }
}

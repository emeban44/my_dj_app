import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_dj_app/models/lobby.dart';
import 'package:my_dj_app/models/sharedPrefs.dart';
import 'package:my_dj_app/providers/timer_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_countdown_timer/index.dart';

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
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 255,
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
                        label: Text(
                          'CREATE A LOBBY',
                          style: TextStyle(fontSize: 21),
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 220,
                      margin: const EdgeInsets.only(top: 7),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () {
                          Provider.of<Lobbies>(context, listen: false)
                              .fetchAndSetPreviousLobby();
                        },
                        icon: Icon(Icons.restore_sharp),
                        label: Text(
                          'RESTORE PREVIOUS',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 10),
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
                        fontSize: 36,
                        fontFamily: 'Doctor',
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                Consumer<LobbyTimer>(
                    builder: (context, timeData, child) => Text(
                          timeData.timeLeft.toString() + ' seconds left',
                          style: TextStyle(
                            color: Colors.grey.shade200,
                            fontFamily: 'Grobold',
                            fontSize: 20,
                          ),
                        )),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('lobbies')
                      .doc(SharedPrefs().userId)
                      .snapshots(),
                  builder: (ctx, AsyncSnapshot<DocumentSnapshot> pollSnapshot) {
                    if (pollSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final pollSongs = pollSnapshot.data;
                    return pollSongs['poll'].length == 0
                        ? Container(
                            margin: EdgeInsets.all(30),
                            child: Text(
                              'No poll created yet!',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.pink,
                                fontFamily: 'PTSans',
                              ),
                            ),
                          )
                        : Flexible(
                            child: Container(
                              height: double.parse(
                                      pollSongs['poll'].length.toString()) *
                                  71,
                              margin: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey,
                                    offset: (Offset.zero),
                                    blurRadius: 5.0,
                                    spreadRadius: 5.0,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade100,
                                    Colors.purple.shade100
                                  ],
                                ),
                              ),
                              child: ListView.builder(
                                  itemCount: pollSongs['poll'].length,
                                  itemBuilder: (ctx, i) => Container(
                                        decoration: BoxDecoration(
                                          border: i ==
                                                  (pollSongs['poll'].length - 1)
                                              ? null
                                              : Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 0.1,
                                                  ),
                                                ),
                                        ),
                                        child: Container(
                                          height: 70,
                                          child: Center(
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor:
                                                    Colors.blueGrey,
                                                child: Icon(
                                                  Icons.music_note_rounded,
                                                  color: Colors.pink.shade100,
                                                ),
                                              ),
                                              title: Text(
                                                pollSongs['poll']['song$i'],
                                                style: TextStyle(
                                                    fontFamily: 'Lexend',
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                            ),
                          );
                  },
                ),
                TextButton(onPressed: () {}, child: Text('VOTE')),
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

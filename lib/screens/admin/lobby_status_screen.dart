import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_dj_app/models/lobby.dart';
import 'package:my_dj_app/models/sharedPrefs.dart';
import 'package:my_dj_app/providers/timer_provider.dart';
import 'package:my_dj_app/screens/admin/admin_suggestions_screen.dart';
import 'package:my_dj_app/widgets/user/vote_percentage_stream.dart';
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
  bool _isLoading = false;
  int timeRemaining = 0;
  //CountdownTimerController _timerController;
  //
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  void timer() {
    Provider.of<LobbyTimer>(context, listen: false).streamTimer();
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
                      height: 90,
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
                      height: 60,
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
        : SingleChildScrollView(
            child: Container(
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
                              offset: Offset(3.5, 3.5),
                              blurRadius: 1.0,
                            ),
                          ],
                          fontFamily: 'Doctor',
                          fontSize: 36,
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
                              offset: Offset(3.5, 3.5),
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
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('lobbies')
                        .doc(SharedPrefs().userId)
                        .snapshots(),
                    builder: (ctx, usersLobbyInfo) {
                      //  if (_isLoading)
                      //  return CircularProgressIndicator.adaptive();
                      if (usersLobbyInfo.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final usersData = usersLobbyInfo.data;
                      try {
                        return Text(
                          'Users in lobby:  ' +
                              usersData['users'].length.toString() +
                              '/' +
                              currentLobby.capacity.toString(),
                          style: TextStyle(
                            color: Colors.blue.shade200,
                            fontFamily: 'Lexend',
                            fontSize: 20,
                          ),
                        );
                      } catch (error) {
                        return Text('0');
                      }
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 5),
                    child: Text(
                      'Current poll: ',
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: 25,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('lobbies')
                        .doc(SharedPrefs().userId)
                        .snapshots(),
                    builder:
                        (ctx, AsyncSnapshot<DocumentSnapshot> pollSnapshot) {
                      if (pollSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final pollSongs = pollSnapshot.data;
                      return pollSongs['poll'].length == 0
                          ? Container(
                              height: 70,
                              margin: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade100,
                                    Colors.purple.shade100
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  'No poll created yet!',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'PTSans',
                                  ),
                                ),
                              ),
                            )
                          : Flexible(
                              child: Container(
                                height: double.parse(
                                        pollSongs['poll'].length.toString()) *
                                    71,
                                margin: EdgeInsets.only(
                                  top: 5,
                                  left: 10,
                                  right: 10,
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
                                                    (pollSongs['poll'].length -
                                                        1)
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
                                                trailing: _isLoading
                                                    ? null
                                                    : VotePercentageStream(
                                                        SharedPrefs().userId,
                                                        i,
                                                        true),
                                              ),
                                            ),
                                          ),
                                        )),
                              ),
                            );
                    },
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('lobbies')
                        .doc(SharedPrefs().userId)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot> lobbySnapshot) {
                      if (lobbySnapshot.connectionState ==
                          ConnectionState.waiting)
                        return CircularProgressIndicator();
                      final lobbyData = lobbySnapshot.data;
                      return Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: Text(
                          lobbyData.data()['lobbyTimer'].toString() +
                              ' seconds left',
                          style: TextStyle(
                            color: Colors.blue.shade200,
                            fontFamily: 'Grobold',
                            fontSize: 22,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Container(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    AdminSuggestionsScreen.routeName);
                              },
                              icon: Icon(Icons.chat),
                              label: Text('SUGGESTIONS'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.pink.shade800,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.music_note),
                              label: Text('POLL WINNERS'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue.shade800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  //          ElevatedButton(onPressed: timer, child: Text('click')),
                ],
              ),
            ),
          );
  }
}

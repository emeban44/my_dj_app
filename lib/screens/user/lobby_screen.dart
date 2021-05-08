import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_dj_app/models/sharedPrefs.dart';
import 'package:my_dj_app/providers/lobbies_provider.dart';
import 'package:my_dj_app/providers/poll_provider.dart';
import 'package:my_dj_app/providers/timer_provider.dart';
import 'package:my_dj_app/providers/users_provider.dart';
import 'package:my_dj_app/widgets/user/vote_percentage_stream.dart';
import 'package:provider/provider.dart';

class LobbyScreen extends StatefulWidget {
  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    if (Provider.of<LobbyTimer>(context, listen: false).timeLeft == 0)
      Provider.of<LobbyTimer>(context, listen: false).setTimeLeft(
          Provider.of<Lobbies>(context, listen: false).getLobbyDuration);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    /* setState(() {
      _isLoading = true;
    }); */
    bool didVote = false;
    await FirebaseFirestore.instance
        .collection('lobbies')
        .doc(Provider.of<Users>(context, listen: false).getLobbyId)
        .get()
        .then((doc) {
      doc.data()['pollVotesCounter'].forEach((key, value) {
        if (key == SharedPrefs().userId) {
          //   print('yes');
          didVote = true;
          return;
        }
      });
      setState(() {
        if (didVote) _didVote = true;
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  void timer() {
    Provider.of<LobbyTimer>(context, listen: false).timer();
  }

  List<bool> _selection = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  bool _isLoading = false;

  bool _didVote = false;

  bool _tryVote = false;

  @override
  Widget build(BuildContext context) {
    final currentLobby = Provider.of<Lobbies>(context).getCurrentLobby;
    final lobbyId = Provider.of<Users>(context).getLobbyId;

    return SingleChildScrollView(
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
            Container(
              //   width: 200,
              child: Row(
                //      mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Users in lobby:   ',
                    style: TextStyle(
                      color: Colors.blue.shade200,
                      fontFamily: 'Lexend',
                      fontSize: 20,
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('lobbies')
                        .doc(lobbyId)
                        .snapshots(),
                    builder: (ctx, usersLobbyInfo) {
                      if (_isLoading)
                        return CircularProgressIndicator.adaptive();
                      /*           if (usersLobbyInfo.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } */
                      final usersData = usersLobbyInfo.data;
                      try {
                        return Text(
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
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Text(
                'Current poll:',
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 25,
                  fontFamily: 'Lexend',
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('lobbies')
                  .doc(lobbyId)
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<DocumentSnapshot> pollSnapshot) {
                if (_isLoading) return CircularProgressIndicator();
                /*      if (pollSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } */
                final pollSongs = pollSnapshot.data;
                return pollSongs['poll'].length == 0
                    ? Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade100,
                              Colors.purple.shade100
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.all(30),
                        child: Text(
                          'No poll created yet!',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.pink,
                            fontFamily: 'PTSans',
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Flexible(
                        child: Container(
                          height: double.parse(
                                  pollSongs['poll'].length.toString()) *
                              71,
                          /*  height: double.parse(
                                  (currentLobby.songsPerPoll).toString()) *
                              71, */
                          margin: EdgeInsets.only(
                            top: 15,
                            left: 20,
                            right: 20,
                            bottom: 7,
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
                              shrinkWrap: true,
                              itemCount: pollSongs['poll'].length,
                              itemBuilder: (ctx, i) => Container(
                                    decoration: BoxDecoration(
                                      color: _selection[i]
                                          ? Colors.black87
                                          : Colors.transparent,
                                      border:
                                          i == (pollSongs['poll'].length - 1)
                                              ? null
                                              : Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 0.1,
                                                  ),
                                                ),
                                    ),
                                    child: InkWell(
                                      onTap: _didVote
                                          ? null
                                          : () {
                                              setState(() {
                                                for (int y = 0;
                                                    y < _selection.length;
                                                    y++) {
                                                  if (i == y)
                                                    continue;
                                                  else
                                                    _selection[y] = false;
                                                }
                                                _selection[i] = !_selection[i];
                                              });
                                              //   print(_selection);
                                            },
                                      child: Container(
                                        height: 70,
                                        child: Center(
                                          child: ListTile(
                                            leading: Container(
                                              //height: 200,
                                              child: CircleAvatar(
                                                backgroundColor: _selection[i]
                                                    ? Colors.pink.shade100
                                                    : Colors.blueGrey,
                                                child: Icon(
                                                  Icons.music_note_rounded,
                                                  color: _selection[i]
                                                      ? Colors.blueGrey
                                                      : Colors.pink.shade100,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              pollSongs['poll']['song$i'],
                                              style: TextStyle(
                                                  fontFamily: 'Lexend',
                                                  fontSize: 19,
                                                  color: _selection[i]
                                                      ? Colors.grey.shade200
                                                      : Colors.black),
                                            ),
                                            trailing: _isLoading
                                                ? null
                                                : _didVote
                                                    ? VotePercentageStream(
                                                        lobbyId, i, false)
                                                    : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      );
              },
            ),
            Container(
              width: 150,
              height: 45,
              margin: const EdgeInsets.only(
                bottom: 13,
                top: 5,
              ),
              child: _tryVote
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: _didVote
                          ? null
                          : () {
                              setState(() {
                                _tryVote = true;
                              });
                              int songIndex;
                              for (int i = 0; i < _selection.length; i++) {
                                if (_selection[i]) songIndex = i;
                              }
                              if (songIndex == null) return;
                              Provider.of<Polls>(context, listen: false)
                                  .registerVote(
                                      songIndex, lobbyId, SharedPrefs().userId)
                                  .then((_) {
                                //          SharedPrefs().toggleVotingStatus(true);
                                setState(() {
                                  _didVote = true;
                                  for (int i = 0; i < _selection.length; i++) {
                                    _selection[i] = false;
                                  }
                                  _tryVote = false;
                                });
                              });
                            },
                      child: Text(
                        _didVote ? 'YOU VOTED' : 'VOTE',
                        style: TextStyle(fontFamily: 'Lexend', fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.black54)),
            ),
            Consumer<LobbyTimer>(
              builder: (context, timeData, child) => Text(
                timeData.timeLeft.toString() + ' seconds left',
                style: TextStyle(
                  color: Colors.blue.shade100,
                  fontFamily: 'Grobold',
                  fontSize: 14,
                ),
              ),
            ),
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
      ),
    );

    /*Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          width: double.infinity,
          height: 500,
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 1,
                child: Stack(
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
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: 200,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Users in lobby:',
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          fontFamily: 'Lexend',
                        ),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('lobbies')
                              .doc(lobbyId)
                              .snapshots(),
                          builder: (ctx, usersLobbyInfo) {
                            final usersData = usersLobbyInfo.data;
                            return Text(
                              usersData['users'].length.toString() +
                                  '/' +
                                  currentLobby.capacity.toString(),
                              style: TextStyle(
                                  color: Colors.grey.shade200,
                                  fontFamily: 'Lexend'),
                            );
                          })
                    ],
                  ),
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('lobbies')
                    .doc(lobbyId)
                    .snapshots(),
                builder: (ctx, AsyncSnapshot<DocumentSnapshot> pollSnapshot) {
                  if (pollSnapshot.connectionState == ConnectionState.waiting) {
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
                          flex: 8,
                          child: Container(
                            height: double.parse(
                                    pollSongs['poll'].length.toString()) *
                                58,
                            margin: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 5,
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
                                        border:
                                            i == (pollSongs['poll'].length - 1)
                                                ? null
                                                : Border(
                                                    bottom: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.1,
                                                    ),
                                                  ),
                                      ),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.blueGrey,
                                          child: Icon(
                                            Icons.music_note_rounded,
                                            color: Colors.pink.shade100,
                                          ),
                                        ),
                                        title: Text(
                                          pollSongs['poll']['song$i'],
                                          style:
                                              TextStyle(fontFamily: 'Lexend'),
                                        ),
                                      ),
                                    )),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    ); */
  }
}

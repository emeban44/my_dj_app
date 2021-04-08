import 'package:flutter/material.dart';
import 'package:my_dj_app/models/lobby.dart';
import 'package:my_dj_app/providers/lobbies_provider.dart';
import 'package:my_dj_app/widgets/admin/lobby_duration_radio_row.dart';
import 'package:my_dj_app/widgets/admin/lobby_song_number.dart';
import 'package:my_dj_app/widgets/admin/lobby_text_input.dart';
import 'package:provider/provider.dart';

class CreateLobbyScreen extends StatefulWidget {
  static const routeName = '/create-lobby';

  @override
  _CreateLobbyScreenState createState() => _CreateLobbyScreenState();
}

class _CreateLobbyScreenState extends State<CreateLobbyScreen> {
  final _lobbyCreationFormKey = GlobalKey<FormState>();

  String finalLobbyName;

  int finalLobbyCapacity;

  bool isValid;

  int lobbyDuration = 0;

  int lobbySongsTotal = 0;

  bool isLoading = false;

  void setLobbyInfo(String value, String hint) {
    if (hint == 'Lobby Name')
      finalLobbyName = value;
    else if (hint == 'Lobby Capacity') finalLobbyCapacity = int.parse(value);
  }

  void _tryLobbyCreate() {
    isValid = _lobbyCreationFormKey.currentState.validate();
    if (lobbyDuration == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please provide a lobby duration',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    } else if (lobbySongsTotal == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please set the number of songs',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    } else if (isValid) {
      _lobbyCreationFormKey.currentState.save();
      setState(() {
        isLoading = true;
      });
      Provider.of<Lobbies>(context, listen: false)
          .createLobby(Lobby(
        name: finalLobbyName,
        capacity: finalLobbyCapacity,
        duration: lobbyDuration,
        songsPerPoll: lobbySongsTotal,
      ))
          .whenComplete(() {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Lobby Created!',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
        Navigator.of(context).pop();
      });
      print(finalLobbyName);
      print(finalLobbyCapacity);
      print(lobbyDuration);
      print(lobbySongsTotal);
    }
  }

  void setLobbyDuration(int duration) {
    lobbyDuration = duration;
  }

  void setSongsTotal(int totalSongs) {
    lobbySongsTotal = totalSongs;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(10, 5, 27, 0.9),
              Color.fromRGBO(33, 98, 131, 0.9),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Create New Lobby'),
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _lobbyCreationFormKey,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    LobbyTextInput('Lobby Name', setLobbyInfo),
                    LobbyTextInput('Lobby Capacity', setLobbyInfo),
                    Text(
                      'Lobby Name & Capacity',
                      style: TextStyle(color: Colors.grey.shade300),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        margin: EdgeInsets.only(top: 15, bottom: 25),
                        width: double.infinity,
                        child: LobbyDurationRadioButtonRow(setLobbyDuration)),
                    Text(
                      'Lobby Voting Duration',
                      style: TextStyle(color: Colors.grey.shade300),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        margin: EdgeInsets.only(top: 15, bottom: 25),
                        width: double.infinity,
                        child: LobbySongNumberRow(setSongsTotal)),
                    Text(
                      'Number of songs per poll',
                      style: TextStyle(color: Colors.grey.shade300),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 18),
                      width: 200,
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue.shade200,
                            Colors.pink.shade200,
                          ],
                        ),
                      ),
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : TextButton.icon(
                              onPressed: _tryLobbyCreate,
                              icon: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                              label: Text(
                                'CREATE LOBBY',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_dj_app/models/lobby.dart';
import 'package:my_dj_app/models/sharedPrefs.dart';

class Lobbies with ChangeNotifier {
  static Lobby _lobby = Lobby(
    name: 'Non-existent',
    capacity: 0,
    duration: 0,
    songsPerPoll: 0,
  );

  Future<void> createLobby(Lobby lobby) async {
    try {
      await FirebaseFirestore.instance
          .collection('lobbies')
          .doc(SharedPrefs().userId)
          .set({
        'lobbyName': lobby.name,
        'lobbyCapacity': lobby.capacity,
        'lobbyDuration': lobby.duration,
        'lobbySongsPerPoll': lobby.songsPerPoll,
      });
    } catch (error) {
      print(error.message);
      throw error;
    }
    _lobby = lobby;
    notifyListeners();
  }

  Lobby get getCurrentLobby {
    Lobby currentLobby = Lobby(
      name: _lobby.name,
      capacity: _lobby.capacity,
      duration: _lobby.duration,
      songsPerPoll: _lobby.songsPerPoll,
    );
    return currentLobby;
  }

  int get getLobbyDuration {
    return _lobby.duration;
  }
}

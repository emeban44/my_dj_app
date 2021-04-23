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
    lobbyCode: '',
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
        'lobbyCode': lobby.lobbyCode,
        'poll': {},
        'users': {},
        'pollVotes': {},
        'pollVotesCounter': {},
      });
    } catch (error) {
      print(error.message);
      throw error;
    }
    _lobby = lobby;
    notifyListeners();
  }

  Future<void> fetchAndSetPreviousLobby() async {
    try {
      final previousLobby = await FirebaseFirestore.instance
          .collection('lobbies')
          .doc(SharedPrefs().userId)
          .get();
      final tmpLobby = Lobby(
        name: previousLobby.data()['lobbyName'],
        capacity: previousLobby.data()['lobbyCapacity'],
        duration: previousLobby.data()['lobbyDuration'],
        songsPerPoll: previousLobby.data()['lobbySongsPerPoll'],
        lobbyCode: previousLobby.data()['lobbyCode'],
      );
      _lobby = tmpLobby;
      notifyListeners();
    } catch (error) {
      print(error.message);
      throw error;
    }
  }

  Future<void> fetchAndSetUserLobby() async {
    final adminId = await FirebaseFirestore.instance
        .collection('lobbyCodes')
        .doc(_lobby.lobbyCode)
        .get();
    print(adminId['lobbyCodeAsAdminId']);
    try {
      final lobbyFrom = await FirebaseFirestore.instance
          .collection('lobbies')
          .doc(adminId['lobbyCodeAsAdminId'])
          .get();
      final tmpLobby = Lobby(
        name: lobbyFrom.data()['lobbyName'],
        capacity: lobbyFrom.data()['lobbyCapacity'],
        duration: lobbyFrom.data()['lobbyDuration'],
        songsPerPoll: lobbyFrom.data()['lobbySongsPerPoll'],
        lobbyCode: lobbyFrom.data()['lobbyCode'],
      );
      _lobby = tmpLobby;
      notifyListeners();
    } catch (error) {
      print(error.message);
      throw error;
    }
  }

  Lobby get getCurrentLobby {
    Lobby currentLobby = Lobby(
      name: _lobby.name,
      capacity: _lobby.capacity,
      duration: _lobby.duration,
      songsPerPoll: _lobby.songsPerPoll,
      lobbyCode: _lobby.lobbyCode,
    );
    return currentLobby;
  }

  int get getLobbyDuration {
    return _lobby.duration;
  }

  int get getLobbySongsPerPoll {
    return _lobby.songsPerPoll;
  }

  void setLobbyCode(String code) {
    _lobby.lobbyCode = code;
  }
}

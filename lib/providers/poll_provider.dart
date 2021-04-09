import 'package:flutter/material.dart';
import 'package:my_dj_app/models/poll.dart';
import 'package:my_dj_app/models/song.dart';
import 'package:my_dj_app/providers/lobbies_provider.dart';

class Polls with ChangeNotifier {
  List<Song> _currentPoll = [];

  void addToPoll(Song song) {
    _currentPoll.add(song);
    notifyListeners();
  }

  void removeFromPoll(Song song) {
    _currentPoll.removeWhere((element) => element == song);
    notifyListeners();
  }

  List<Song> get getCurrentPollSongs {
    return [..._currentPoll];
  }
}

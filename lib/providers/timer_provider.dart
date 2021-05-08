import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_dj_app/models/sharedPrefs.dart';

import 'lobbies_provider.dart';

class LobbyTimer with ChangeNotifier {
  int timeRemaining = Lobbies().getLobbyDuration;

  void timer() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      timeRemaining--;
      notifyListeners();
      if (timeRemaining == 0 || timeRemaining < 0) t.cancel();
    });
  }

  void streamTimer() {
    const oneSec = const Duration(seconds: 1);
    final String userId = SharedPrefs().userId;
    new Timer.periodic(oneSec, (Timer t) async {
      int newTime = SharedPrefs().lobbyDuration;
      SharedPrefs().setLobbyDuration(newTime - 1);
      /*final lobbyData = await FirebaseFirestore.instance
          .collection('lobbies')
          .doc(userId)
          .get();*/
      //  print(newTime);
      FirebaseFirestore.instance.collection('lobbies').doc(userId).update({
        'lobbyTimer': SharedPrefs().lobbyDuration,
      });
      //   notifyListeners();
      if (timeRemaining == 0 || timeRemaining < 0) t.cancel();
    });
  }

  int get timeLeft {
    return timeRemaining;
  }

  void setTimeLeft(int time) {
    this.timeRemaining = time;
  }
}

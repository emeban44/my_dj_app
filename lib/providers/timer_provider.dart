import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  int get timeLeft {
    return timeRemaining;
  }

  void setTimeLeft(int time) {
    this.timeRemaining = time;
  }
}

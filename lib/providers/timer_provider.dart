import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'lobbies_provider.dart';

class LobbyTimer with ChangeNotifier {
  static int timeRemaining = Lobbies().getLobbyDuration;

  void timer() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      timeRemaining--;
      notifyListeners();
    });
  }

  int get timeLeft {
    return timeRemaining;
  }
}

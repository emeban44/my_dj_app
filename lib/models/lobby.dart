import 'package:flutter/material.dart';

class Lobby {
  final String name;
  final int capacity;
  int duration;
  final int songsPerPoll;
  String lobbyCode;

  Lobby({
    @required this.name,
    @required this.capacity,
    @required this.duration,
    @required this.songsPerPoll,
    this.lobbyCode,
  });
}

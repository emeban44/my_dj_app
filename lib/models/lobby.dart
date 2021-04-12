import 'package:flutter/material.dart';

class Lobby {
  final String name;
  final int capacity;
  final int duration;
  final int songsPerPoll;
  final String lobbyCode;

  Lobby({
    @required this.name,
    @required this.capacity,
    @required this.duration,
    @required this.songsPerPoll,
    this.lobbyCode,
  });
}

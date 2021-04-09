import 'package:my_dj_app/models/song.dart';

class Poll {
  List<Song> pollSongs = [];

  void addSongToPoll(Song song) {
    pollSongs.add(song);
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_dj_app/models/sharedPrefs.dart';

import '../models/song.dart';

class Songs with ChangeNotifier {
  static List<Song> _songs = [];

  List<Song> get songs {
    return [..._songs];
  }

  List<Song> getSongsByGenre(String genre) {
    List<Song> songsByGenre =
        _songs.where((song) => song.genres.contains(genre)).toList();
    songsByGenre.sort((a, b) => a.artist.compareTo(b.artist));
    return songsByGenre;
  }

  static Future<void> initSongs() async {
    try {
      final songs =
          await FirebaseFirestore.instance.collection('songsStarterPack').get();
      // final List<Song> songsToReturn = [];
      final userId = SharedPrefs().userId;
      songs.docs.forEach((document) async {
        await FirebaseFirestore.instance
            .collection('adminSongs')
            .doc(userId)
            .collection('songsList')
            .doc()
            .set({
          'songName': document['songName'],
          'songArtist': document['songArtist'],
          'songGenres': document['songGenres'],
        });
        _songs.add(Song(
          document['songName'],
          document['songArtist'],
          (document['songGenres'] as List)
              ?.map((item) => item as String)
              ?.toList(),
        ));
        //    print(songsToReturn[0].genres.runtimeType);
      });
      SharedPrefs().initalizeSongs();
    } catch (error) {
      print('An error ocurred while initialising');
      throw error;
    }
  }

  Future<void> fetchAndSetSongs() async {
    final userId = SharedPrefs().userId;
    final songs = await FirebaseFirestore.instance
        .collection('adminSongs')
        .doc(userId)
        .collection('songsList')
        .get();
    final List<Song> songsToReturn = [];
    songs.docs.forEach((doc) {
      songsToReturn.add(Song(
        doc['songName'],
        doc['songArtist'],
        (doc['songGenres'] as List)?.map((item) => item as String)?.toList(),
      ));
    });
    _songs = songsToReturn;
    notifyListeners();
    //   return songsToReturn;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_dj_app/models/sharedPrefs.dart';
import 'package:my_dj_app/models/song.dart';
import 'package:my_dj_app/providers/songs_provider.dart';
import 'package:provider/provider.dart';

class LobbyStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            //    SharedPrefs().initalizeSongs();
            //    FirebaseAuth.instance.signOut();
            List<Song> songs = Provider.of<Songs>(context, listen: false).songs;
            print(songs.length);
          },
          child: Text(
            'LOGOUT MATE',
            style: TextStyle(color: Colors.grey.shade100),
          )),
    );
  }
}

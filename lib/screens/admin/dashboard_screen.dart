import 'package:flutter/material.dart';
import 'package:my_dj_app/models/sharedPrefs.dart';
import '../../screens/admin/add_song_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Add new song'),
        onPressed: () {
          SharedPrefs().initalizeSongs();
          Navigator.of(context).pushNamed(AddSongScreen.routeName);
        },
      ),
    );
  }
}

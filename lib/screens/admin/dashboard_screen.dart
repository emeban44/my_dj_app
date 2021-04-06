import 'package:flutter/material.dart';
import '../../screens/admin/add_song_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Add new song'),
        onPressed: () {
          Navigator.of(context).pushNamed(AddSongScreen.routeName);
        },
      ),
    );
  }
}

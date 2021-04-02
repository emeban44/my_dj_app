import 'package:flutter/material.dart';

class SongsByGenre extends StatelessWidget {
  final String genre;
  final Function goBack;
  SongsByGenre(this.genre, this.goBack);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: Text(genre),
          ),
          ElevatedButton(onPressed: goBack, child: Text('Back')),
        ],
      ),
    );
  }
}

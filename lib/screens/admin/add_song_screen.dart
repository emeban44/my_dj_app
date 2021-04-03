import 'package:flutter/material.dart';
import 'package:my_dj_app/widgets/admin/genre_check_box.dart';
import '../../widgets/admin/song_text_input.dart';
import '../../models/genres.dart';

class AddSongScreen extends StatelessWidget {
  static const routeName = '/add-song';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(10, 5, 27, 0.9),
            Color.fromRGBO(33, 98, 131, 0.9),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Add New Song'),
          backgroundColor: Colors.transparent,
        ),
        body: Form(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SongTextInput('Song Name'),
                SongTextInput('Song Artist'),
                Text(
                  'Song Name & Artist',
                  style: TextStyle(color: Colors.grey.shade300),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        GenreCheckBox(Genres.genres[0]),
                        GenreCheckBox(Genres.genres[1]),
                        GenreCheckBox(Genres.genres[2]),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

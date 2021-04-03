import 'package:flutter/material.dart';
import 'package:my_dj_app/widgets/admin/genre_check_box.dart';
import '../../widgets/admin/song_text_input.dart';
import '../../models/genres.dart';

class AddSongScreen extends StatelessWidget {
  static const routeName = '/add-song';
  static final List<bool> isChecked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  void toggleChecked(int index) {
    isChecked[index] = !isChecked[index];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
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
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Icon(Icons.add),
              ),
            ],
            title: Text('Add New Song'),
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Form(
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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GenreCheckBox(Genres.genres[0], toggleChecked, 0),
                              GenreCheckBox(Genres.genres[1], toggleChecked, 1),
                              GenreCheckBox(Genres.genres[2], toggleChecked, 2),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GenreCheckBox(Genres.genres[3], toggleChecked, 3),
                              GenreCheckBox(Genres.genres[4], toggleChecked, 4),
                              GenreCheckBox(Genres.genres[5], toggleChecked, 5),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GenreCheckBox(Genres.genres[6], toggleChecked, 6),
                              GenreCheckBox(Genres.genres[7], toggleChecked, 7),
                              GenreCheckBox(Genres.genres[8], toggleChecked, 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Pick Song Genres',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    Container(
                      width: 190,
                      padding: const EdgeInsets.only(top: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            print(isChecked);
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          label: Text(
                            'Add Song',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink.shade200,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

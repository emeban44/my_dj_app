import 'package:flutter/material.dart';

import '../../widgets/admin/songs_by_genre.dart';
import '../../widgets/admin/genre_item.dart';
import '../../models/genres.dart';

class SongsScreen extends StatefulWidget {
  @override
  _SongsScreenState createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  var showByGenre = false;
  var genre;

  void toggleGenres(String genreFrom) {
    setState(() {
      showByGenre = true;
      genre = genreFrom;
    });
  }

  void goBack() {
    setState(() {
      showByGenre = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showByGenre
        ? SongsByGenre(genre, goBack)
        : GridView(
            padding: const EdgeInsets.all(25),
            children: Genres.genres
                .map((genreData) => GenreItem(
                      genreData,
                      Colors.pink,
                      toggleGenres,
                    ))
                .toList(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
          );
  }
}

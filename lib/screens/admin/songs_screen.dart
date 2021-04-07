import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  bool searching = false;
  final _searchController = TextEditingController();

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

  void searchSongs() {
    if (_searchController.text.isEmpty) return;
  }

  @override
  Widget build(BuildContext context) {
    return showByGenre
        ? SongsByGenre(genre, goBack)
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                margin:
                    EdgeInsets.only(top: 15, right: 25, left: 25, bottom: 5),
                //    color: Colors.purple,
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue.shade100, Colors.pink.shade200],
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 4,
                      child: TextFormField(
                        controller: _searchController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          //    fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: IconButton(
                            icon: Icon(Icons.search), onPressed: () {}),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: GridView(
                  padding: const EdgeInsets.only(
                      right: 25, left: 25, bottom: 25, top: 15),
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
                ),
              ),
            ],
          );
  }
}

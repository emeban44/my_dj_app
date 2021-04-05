import 'package:flutter/material.dart';
import 'package:my_dj_app/widgets/admin/songs_future_builder.dart';
import 'package:provider/provider.dart';
import 'package:my_dj_app/models/sharedPrefs.dart';
import 'package:my_dj_app/providers/songs_provider.dart';

class SongsByGenre extends StatelessWidget {
  final String genre;
  final Function goBack;
  SongsByGenre(this.genre, this.goBack);
  @override
  Widget build(BuildContext context) {
    return !SharedPrefs().didSongsInit
        ? FutureBuilder(
            future: Songs.initSongs(),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator.adaptive());
              } else
                return SongsFutureBuilder();
            })
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                child: Row(
                  //      mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back_rounded),
                        onPressed: goBack),
                    Text(
                      genre + 'Songs',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(child: SongsFutureBuilder()),
            ],
          );
  }
}

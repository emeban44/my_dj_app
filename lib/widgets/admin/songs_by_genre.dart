import 'package:flutter/material.dart';
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
                return CircularProgressIndicator.adaptive();
              } else
                return FutureBuilder(
                    future: Songs.getSongs,
                    builder: (ctx, snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator.adaptive();
                      }
                      return ListView.builder(
                          itemCount: snapShot.data.length,
                          itemBuilder: (ctx, i) {
                            return ListTile(
                              leading: CircleAvatar(),
                            );
                          });
                    });
            })
        : Column(
            children: [
              Container(
                child: Text(genre),
              ),
              ElevatedButton(onPressed: goBack, child: Text('Back')),
              //          ListView.builder(itemBuilder: (ctx, i){
              //            return ListTile(leading: CircleAvatar(), trailing: ,)
              //          })
            ],
          );
  }
}

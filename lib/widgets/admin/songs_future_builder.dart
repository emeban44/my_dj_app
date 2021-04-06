import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/songs_provider.dart';

class SongsFutureBuilder extends StatefulWidget {
  final String genre;

  SongsFutureBuilder(this.genre);
  @override
  _SongsFutureBuilderState createState() => _SongsFutureBuilderState();
}

class _SongsFutureBuilderState extends State<SongsFutureBuilder> {
  /*
  Future _songsFuture;

  Future _obtainSongsFuture() {
    return Provider.of<Songs>(context, listen: false).fetchAndSetSongs();
  } */

  Future<void> _refreshSongs(BuildContext context) async {
    await Provider.of<Songs>(context, listen: false).fetchAndSetSongs();
  }

  @override
  void initState() {
    //  _obtainSongsFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* return FutureBuilder(
        future: _songsFuture,
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            print('čekamo');
            return Center(child: CircularProgressIndicator.adaptive());
          } else */
    return RefreshIndicator(
      onRefresh: () => _refreshSongs(context),
      child: Consumer<Songs>(
        builder: (ctx, songsData, child) => ListView.builder(
            itemCount: songsData.getSongsByGenre(widget.genre).length,
            shrinkWrap: true,
            itemBuilder: (ctx, i) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 0.1,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: InkWell(
                  onLongPress: () {
                    Provider.of<Songs>(context, listen: false).deleteSong(
                      songsData.getSongsByGenre(widget.genre)[i].name,
                      songsData.getSongsByGenre(widget.genre)[i].artist,
                    );
                  },
                  child: ListTile(
                    key: ValueKey(
                      songsData.getSongsByGenre(widget.genre)[i].artist +
                          ' - ' +
                          songsData.getSongsByGenre(widget.genre)[i].name,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.black26,
                      child: Icon(
                        Icons.music_note,
                        color: Colors.pink,
                      ),
                    ),
                    title: Text(
                      songsData.getSongsByGenre(widget.genre)[i].artist +
                          ' - ' +
                          songsData.getSongsByGenre(widget.genre)[i].name,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 14,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.add_circle_outline,
                              color: Colors.pink),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
    //      });
  }
}

import 'package:flutter/material.dart';
import '../../providers/songs_provider.dart';

class SongsFutureBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Songs.getSongs,
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          return ListView.builder(
              itemCount: snapShot.data.length,
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
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black26,
                      child: Icon(Icons.music_note),
                    ),
                    title: Text(
                      snapShot.data[i].artist + ' - ' + snapShot.data[i].name,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.add_circle_outline,
                              color: Colors.blue),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

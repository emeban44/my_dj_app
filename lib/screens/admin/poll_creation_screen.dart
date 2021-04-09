import 'package:flutter/material.dart';
import 'package:my_dj_app/providers/poll_provider.dart';
import 'package:provider/provider.dart';

class PollCreationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: 20,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: 10,
            ),
            child: Text(
              'Songs for the next poll:',
              style: TextStyle(
                color: Colors.grey.shade200,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.blue.shade50,
                    Colors.pink.shade100,
                  ]),
                  //     color: Colors.pink,
                  borderRadius: BorderRadius.circular(18),
                ),
                /*     margin: EdgeInsets.symmetric(
                  vertical: 100,
                  horizontal: 20,
                ), */
                width: double.infinity,
                //   color: Colors.grey,
                child: Consumer<Polls>(
                  builder: (ctx, pollData, child) {
                    return ListView.builder(
                        itemCount: pollData.getCurrentPollSongs.length,
                        itemBuilder: (ctx, i) {
                          return Container(
                            decoration: BoxDecoration(
                              border:
                                  i == (pollData.getCurrentPollSongs.length - 1)
                                      ? null
                                      : Border(
                                          bottom: BorderSide(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Icon(
                                  Icons.music_note_rounded,
                                  color: Colors.pink.shade400,
                                ),
                                backgroundColor: Colors.black87,
                              ),
                              title: Text(
                                pollData.getCurrentPollSongs[i].artist +
                                    ' - ' +
                                    pollData.getCurrentPollSongs[i].name,
                                style: TextStyle(
                                  fontFamily: 'Lexend',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  Provider.of<Polls>(
                                    context,
                                    listen: false,
                                  ).removeFromPoll(
                                      pollData.getCurrentPollSongs[i]);
                                },
                              ),
                            ),
                          );
                        });
                  },
                )),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5,
            ),
            width: 150,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Create Poll'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

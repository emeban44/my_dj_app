import 'package:flutter/material.dart';
import 'package:my_dj_app/providers/poll_provider.dart';
import 'package:provider/provider.dart';

class PollCreationScreen extends StatefulWidget {
  @override
  _PollCreationScreenState createState() => _PollCreationScreenState();
}

class _PollCreationScreenState extends State<PollCreationScreen> {
  @override
  Widget build(BuildContext context) {
    double pollSize =
        Provider.of<Polls>(context).getCurrentPollSize.roundToDouble();
    return Container(
      margin: EdgeInsets.only(
        top: 50,
        left: 20,
        right: 20,
      ),
      height: pollSize == 0 ? 150 : pollSize * 58 + 90,
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
              padding: EdgeInsets.only(
                top: 2,
              ),
              width: double.infinity,
              //   color: Colors.grey,
              child: pollSize == 0
                  ? Center(
                      child: Text(
                        'Start adding songs to the poll',
                        style: TextStyle(
                          fontFamily: 'PTSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : Consumer<Polls>(
                      builder: (ctx, pollData, child) {
                        return ListView.builder(
                            itemCount: pollData.getCurrentPollSongs.length,
                            itemBuilder: (ctx, i) {
                              return Container(
                                height: 58,
                                decoration: BoxDecoration(
                                  border: i ==
                                          (pollData.getCurrentPollSongs.length -
                                              1)
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
                                      color: Colors.pink
                                          .shade100, //Colors.pink.shade400,
                                    ),
                                    backgroundColor: Colors.blueGrey.shade700,
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
                    ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5,
            ),
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<Polls>(context, listen: false).createPoll();
              },
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

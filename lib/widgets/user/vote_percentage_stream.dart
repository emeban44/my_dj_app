import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VotePercentageStream extends StatelessWidget {
  final String lobbyId;
  final int index;
  VotePercentageStream(this.lobbyId, this.index);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('lobbies')
          .doc(lobbyId)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> pollVoting) {
        var pollData = pollVoting.data;
        int songTotalVotes = 0;
        int pollTotalVotes = 0;
        try {
          pollTotalVotes = pollData['pollVotesCounter'].length;
        } catch (error) {
          pollTotalVotes = 0;
        }
        try {
          songTotalVotes = pollData['pollVotes']['song$index'].length;
        } catch (error) {
          songTotalVotes = 0;
        }
        /*  if (pollVoting.connectionState == ConnectionState.waiting)
          return Text('0%'); */
        if (songTotalVotes == null) songTotalVotes = 0;
        double songPercentage = songTotalVotes / pollTotalVotes * 100;
        return Text(
          songPercentage.toStringAsFixed(0) + '%',
          style: TextStyle(
              //color:
              ),
        );
      },
    );
  }
}

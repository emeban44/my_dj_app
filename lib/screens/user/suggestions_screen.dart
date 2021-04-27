import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_dj_app/providers/lobbies_provider.dart';
import 'package:my_dj_app/providers/users_provider.dart';
import 'package:provider/provider.dart';

class SuggestionsScreen extends StatelessWidget {
  final _suggestionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lobbyId = Provider.of<Users>(context).getLobbyId;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                //   initialData: Text('No suggestions yet'),
                stream: FirebaseFirestore.instance
                    .collection('lobbies')
                    .doc(lobbyId)
                    .collection('suggestions')
                    .snapshots(),
                builder: (context, suggestionsSnapshot) {
                  if (!suggestionsSnapshot.hasData)
                    return CircularProgressIndicator();
                  final suggestions = suggestionsSnapshot.data.docs;
                  return ListView.builder(
                    itemBuilder: (context, i) {
                      return Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white,
                              width: 0.2,
                            ),
                          ),
                        ),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              suggestions[i].data()['suggestion'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Lexend',
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 2.0, top: 5),
                              child: Text(
                                'Suggested by: ' +
                                    suggestions[i].data()['username'],
                                style: TextStyle(
                                  color: Colors.pink.shade300,
                                  fontSize: 15,
                                  fontFamily: 'Lexend',
                                ),
                              ),
                            ),
                            trailing: Container(
                              height: 80,
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                        height: 80,
                                        width: 48,
                                        decoration: BoxDecoration(
                                            color: Colors.pink.shade600,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Icon(
                                          Icons.thumb_up_sharp,
                                          color: Colors.grey.shade200,
                                        )),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      '1',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: suggestions.length,
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  gradient: LinearGradient(colors: [
                    Colors.blue.shade200,
                    Colors.pink.shade100,
                  ])),
              padding:
                  EdgeInsets.only(left: 20, bottom: 15, right: 15, top: 10),
              child: Row(
                children: [
                  Flexible(
                    flex: 10,
                    child: TextFormField(
                      controller: _suggestionController,
                      autocorrect: false,
                      enableSuggestions: false,
                      //      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                      decoration:
                          InputDecoration(hintText: 'Suggest a song...'),
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.send_rounded),
                        onPressed: () {
                          print(_suggestionController.text);
                        },
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

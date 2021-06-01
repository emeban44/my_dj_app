import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_dj_app/providers/lobbies_provider.dart';
import 'package:my_dj_app/screens/user_screen.dart';
import 'package:provider/provider.dart';

class Users with ChangeNotifier {
  String lobbyId = '';

  String get getLobbyId {
    return this.lobbyId;
  }

  Future<void> addUserToLobby(
    String enteredCode,
    String userId,
    BuildContext context,
  ) async {
    try {
      _showMyDialog('albino', 'boim', context);
      final adminId = await FirebaseFirestore.instance
          .collection('lobbyCodes')
          .doc(enteredCode)
          .get();
      lobbyId = adminId['lobbyCodeAsAdminId'];
    } catch (error) {
      print(error.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not find a lobby with entered code',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
      throw error;
    }
    try {
      final adminId = await FirebaseFirestore.instance
          .collection('lobbyCodes')
          .doc(enteredCode)
          .get();
      final userName = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      await FirebaseFirestore.instance
          .collection('lobbies')
          .doc(adminId['lobbyCodeAsAdminId'])
          .update({
        'users.$userId': userName['username'],
      });
      final fetchedDuration = await FirebaseFirestore.instance
          .collection('lobbies')
          .doc(lobbyId)
          .get();
      Provider.of<Lobbies>(context, listen: false).setLobbyCode(enteredCode);
      Provider.of<Lobbies>(context, listen: false)
          .setLobbyDuration(fetchedDuration['lobbyDuration']);
      notifyListeners();
      // Navigator.of(context).pop();
      Navigator.of(context).pushNamed(UserScreen.routeName);
    } catch (error) {
      print(error.message);
      throw error;
    }
  }

  Future<void> removeUserFromLobby(String userId, String lobbyCode,
      BuildContext context, BuildContext drawer) async {
    print(userId);
    print(lobbyCode);
    Navigator.of(drawer).pop();
    final adminId = await FirebaseFirestore.instance
        .collection('lobbyCodes')
        .doc(lobbyCode)
        .get();
    await FirebaseFirestore.instance
        .collection('lobbies')
        .doc(adminId['lobbyCodeAsAdminId'])
        .update({
      'users.$userId': FieldValue.delete(),
    });
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  Future<void> _showMyDialog(
      String name, String artist, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('Joining lobby...',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black87,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                )),
          ),
          content: Container(
            margin: const EdgeInsets.all(5),
            child: SizedBox(
              height: 40,
              width: 40,
              child: Center(
                  child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.deepPurple.shade800),
                strokeWidth: 3.5,
              )),
            ),
          ),
        );
      },
    );
  }
}

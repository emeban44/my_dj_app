import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_dj_app/providers/lobbies_provider.dart';
import 'package:my_dj_app/screens/user_screen.dart';
import 'package:provider/provider.dart';

class Users with ChangeNotifier {
  Future<void> addUserToLobby(
    String enteredCode,
    String userId,
    BuildContext context,
  ) async {
    try {
      final adminId = await FirebaseFirestore.instance
          .collection('lobbyCodes')
          .doc(enteredCode)
          .get();
      print(adminId['lobbyCodeAsAdminId']);
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
      Provider.of<Lobbies>(context, listen: false).setLobbyCode(enteredCode);
      Navigator.of(context).pushReplacementNamed(UserScreen.routeName);
    } catch (error) {
      print(error.message);
      throw error;
    }
  }
}

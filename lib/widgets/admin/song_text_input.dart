import 'package:flutter/material.dart';

class SongTextInput extends StatelessWidget {
  final String inputHint;

  SongTextInput(this.inputHint);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade200,
            Colors.pink.shade200,
          ],
        ),
      ),
      child: TextFormField(
        style: TextStyle(
          fontFamily: 'Lexend',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none,
          //     helperText: 'Song info',
          hintText: inputHint,
          //        labelText: inputHint,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          focusColor: Colors.white,
        ),
      ),
    );
  }
}
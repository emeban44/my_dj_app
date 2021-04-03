import 'package:flutter/material.dart';

class GenreCheckBox extends StatelessWidget {
  final String genre;

  GenreCheckBox(this.genre);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 100,
        width: 100,
        child: Column(
          children: [
            Text(genre),
            IconButton(
              icon: Icon(Icons.check_box_outline_blank),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

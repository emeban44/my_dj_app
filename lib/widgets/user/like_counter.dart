import 'package:flutter/material.dart';

class LikeCounter extends StatefulWidget {
  @override
  _LikeCounterState createState() => _LikeCounterState();
}

class _LikeCounterState extends State<LikeCounter> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      //    height: 200,
      child: Column(
        children: [
          Flexible(
            flex: 4,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              splashColor: Colors.blue,
              onTap: () {
                setState(() {
                  _liked = !_liked;
                });
              },
              child: Container(
                height: 80,
                width: 48,
                decoration: BoxDecoration(
                    color: Colors.pink.shade600,
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(
                  Icons.thumb_up_sharp,
                  color: _liked
                      ? Colors.deepPurple.shade700
                      : Colors.grey.shade200,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Text(
              '0',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Lexend',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

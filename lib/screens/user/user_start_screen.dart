import 'package:flutter/material.dart';
import 'package:my_dj_app/widgets/app_drawer.dart';

class UserStartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(10, 5, 27, 0.9),
              Color.fromRGBO(33, 98, 131, 0.9),
              //    Colors.pink.shade300,
            ],
          ),
        ),
        child: Scaffold(
            drawer: AppDrawer(),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'Join a Lobby',
                style: TextStyle(fontFamily: 'Raleway'),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
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
                        height: 50,
                        width: 180,
                        child: Container(
                          padding: const EdgeInsets.only(left: 11),
                          child: TextFormField(
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(fontFamily: 'PTSans'),
                              hintText: 'Enter the lobby code',
                              hintStyle: TextStyle(
                                fontFamily: 'Lexend',
                                //         fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple),
                          onPressed: () {},
                          icon: Icon(Icons.people_alt),
                          label: Text('JOIN LOBBY')),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

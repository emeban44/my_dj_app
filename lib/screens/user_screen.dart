import 'package:flutter/material.dart';
import '../screens/user/lobbies_screen.dart';
import '../screens/user/user_profile_screen.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final List<Widget> _pages = [
    LobbiesScreen(),
    UserProfileScreen(),
  ];

  final List<String> _titles = [
    'Find a Lobby',
    'Your Profile',
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Center(
              child: Text(
            _titles[_selectedPageIndex],
            style: TextStyle(fontFamily: 'Raleway'),
          )),
          backgroundColor: Colors.transparent,
        ),
        body: _pages[_selectedPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Color.fromRGBO(10, 5, 27, 0.9),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.pink,
          currentIndex: _selectedPageIndex,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 11,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Icon(Icons.library_music),
              ),
              label: 'LOBBIES',
            ),
            BottomNavigationBarItem(
                icon: Container(
                  child: Icon(Icons.location_history),
                  margin: EdgeInsets.only(bottom: 2),
                ),
                label: 'YOUR PROFILE'),
          ],
        ),
      ),
    );
  }
}

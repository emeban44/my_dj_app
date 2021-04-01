import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/admin/songs_screen.dart';
import 'admin/dashboard_screen.dart';
import 'admin/lobby_status_screen.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final List<Widget> _pages = [
    DashboardScreen(),
    LobbyStatusScreen(),
    SongsScreen(),
  ];

  final List<String> _titles = [
    'Dashboard',
    'Lobby Status',
    'Songs Library',
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
        ), //Colors.transparent.withOpacity(0.8)),
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
                child: Icon(Icons.dashboard),
              ),
              label: 'DASHBOARD',
            ),
            BottomNavigationBarItem(
                icon: Container(
                  child: Icon(Icons.people),
                  margin: EdgeInsets.only(bottom: 2),
                ),
                label: 'LOBBY'),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Icon(Icons.music_note),
              ),
              label: 'SONGS',
            ),
          ],
        ),
      ),
    );
  }
}

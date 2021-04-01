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
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Center(
            child: Text(
          _titles[_selectedPageIndex],
          style: TextStyle(fontFamily: 'Raleway'),
        )),
        backgroundColor: Colors.deepPurple.shade900,
      ),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Color.fromRGBO(10, 5, 27, 0.9),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.pink,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'DESHBORD',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'YEE YEAA'),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'SONGS',
          ),
        ],
      ),
    );
  }
}

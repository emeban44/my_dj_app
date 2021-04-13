import 'package:flutter/material.dart';
import 'package:my_dj_app/providers/lobbies_provider.dart';
import 'package:my_dj_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'user/lobby_screen.dart';
import '../screens/user/user_profile_screen.dart';

class UserScreen extends StatefulWidget {
  static const routeName = '/user-screen';
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    //  Provider.of<Lobbies>(context, listen: false).fetchAndSetUserLobby();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Lobbies>(context, listen: false).fetchAndSetUserLobby();
    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  final List<Widget> _pages = [
    LobbyScreen(),
    UserProfileScreen(),
  ];

  final List<String> _titles = [
    'Lobby Status',
    'Next Songs Suggestions',
  ];

  bool _isLoading = false;

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
        drawer: AppDrawer(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            _titles[_selectedPageIndex],
            style: TextStyle(fontFamily: 'Raleway'),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : _pages[_selectedPageIndex],
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
              label: 'LOBBY',
            ),
            BottomNavigationBarItem(
                icon: Container(
                  child: Icon(Icons.chat_rounded),
                  margin: EdgeInsets.only(bottom: 2),
                ),
                label: 'SUGGESTIONS'),
          ],
        ),
      ),
    );
  }
}

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/screens/discover_screen.dart';
import 'package:flutterappmovie/screens/user_screen.dart';
import '../style/theme.dart' as Style;
import 'movies_screen.dart';
import 'tv_shows_screen.dart';
import '../screens/search_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _screens;

  int _selectedIndex = 0;

  Object _selectedBody(int index) {
    return _screens[index]['body'];
  }

  Object _selectedTitle(int index) {
    return _screens[index]['title'];
  }

  @override
  void initState() {
    super.initState();
    _screens = [
      {'body': MoviesScreen(), 'title': 'Movies'},
      {'body': TVShowsScreen(), 'title': 'TV Shows'},
      {'body': DiscoverScreen(), 'title': 'Discover'},
      {'body': UserScreen(), 'title': 'User'}
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: Icon(EvaIcons.menu2Outline, color: Colors.white),
        title: Text(_selectedTitle(_selectedIndex)),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                EvaIcons.searchOutline,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(SearchScreen.routeName);
              })
        ],
      ),
      body: _selectedBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 15,
        selectedItemColor: Style.Colors.secondColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        backgroundColor: Style.Colors.bottomNavigationBarColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            title: Text(
              'Movies',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.slideshow),
            title: Text(
              'TV Shows',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            title: Text(
              'Discover',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'User',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/movies_screen.dart';
import 'screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabsScreen(),
      routes: {
        MoviesScreen.routeName: (context) => MoviesScreen(),
      },
    );
  }
}

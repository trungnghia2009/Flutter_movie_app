import 'package:flutter/material.dart';
import 'package:flutterappmovie/widgets/popular_persons.dart';
import 'package:flutterappmovie/widgets/b_shows/airing_today.dart';
import 'package:flutterappmovie/widgets/b_shows/genres.dart';
import 'package:flutterappmovie/widgets/b_shows/on_the_air_shows.dart';
import 'package:flutterappmovie/widgets/b_shows/popular_shows.dart';
import 'package:flutterappmovie/widgets/b_shows/top_shows.dart';

class TVShowsScreen extends StatefulWidget {
  @override
  _TVShowsScreenState createState() => _TVShowsScreenState();
}

class _TVShowsScreenState extends State<TVShowsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          AiringToday(),
          GenreShows(),
          PopularPersons(),
          TopShows(),
          PopularShows(),
          OnTheAirShows(),
        ],
      ),
    );
  }
}

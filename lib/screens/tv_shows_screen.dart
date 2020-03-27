import 'package:flutter/material.dart';
import 'package:flutterappmovie/widgets/popular_persons.dart';
import 'package:flutterappmovie/widgets/shows/airing_today.dart';
import 'package:flutterappmovie/widgets/shows/genres.dart';
import 'package:flutterappmovie/widgets/shows/on_the_air_shows.dart';
import 'package:flutterappmovie/widgets/shows/popular_shows.dart';
import 'package:flutterappmovie/widgets/shows/top_shows.dart';

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

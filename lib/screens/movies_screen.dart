import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/widgets/movies/top_movies.dart';
import '../style/theme.dart' as Style;
import '../widgets/movies/now_playing.dart';
import '../widgets/movies/genres.dart';
import '../widgets/movies/trending_persons.dart';
import '../widgets/movies/popular_movies.dart';
import '../widgets/movies/upcoming_movies.dart';
import '../widgets/popular_persons.dart';

class MoviesScreen extends StatelessWidget {
  static const String routeName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          NowPlaying(),
          GenreMovies(),
          TrendingPersons(),
          TopMovies(),
          PopularMovies(),
          UpcomingMovies(),
          PopularPersons(),
        ],
      ),
    );
  }
}

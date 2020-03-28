import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterappmovie/bloc/seach/get_movies_search_bloc.dart';
import 'package:flutterappmovie/model/movies/movie.dart';
import 'package:flutterappmovie/model/movies/movie_response.dart';
import '../../style/theme.dart' as Style;
import '../utility_widgets.dart';

class MoviesSearchResult extends StatefulWidget {
  final String searchValue;
  MoviesSearchResult({this.searchValue});
  @override
  _MoviesSearchResultState createState() => _MoviesSearchResultState();
}

class _MoviesSearchResultState extends State<MoviesSearchResult> {
  var _isInit = true;
  var _isDidUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.searchValue != '' && _isInit) {
      searchMoviesBloc..drainStream();
      searchMoviesBloc..getMovies(widget.searchValue);
    }
    _isInit = false;
  }

  @override
  void didUpdateWidget(MoviesSearchResult oldWidget) {
    print('didUpdateWidget MoviesSearchResult()');
    super.didUpdateWidget(oldWidget);
    if (widget.searchValue != '' && _isDidUpdate) {
      searchMoviesBloc..drainStream();
      searchMoviesBloc..getMovies(widget.searchValue);
    }
    _isDidUpdate = true;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.searchValue + " at MoviesSearchResult");
    return widget.searchValue == ''
        ? utilityWidgets.buildEmptySearchScreen()
        : StreamBuilder<MovieResponse>(
            stream: searchMoviesBloc.subject.stream,
            builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return utilityWidgets.buildErrorWidget(snapshot.data.error);
                }
                return _buildTopMovieWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return utilityWidgets.buildErrorWidget(snapshot.error);
              } else {
                return utilityWidgets.buildLoadingWidget(270);
              }
            },
          );
  }

  Widget _buildTopMovieWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        color: Style.Colors.mainColor,
        child: Center(
            child: Text(
          'No Movies',
          style: TextStyle(fontSize: 20, color: Style.Colors.titleColor),
        )),
      );
    } else
      return Container(
        color: Style.Colors.mainColor,
        height: 270,
        padding: EdgeInsets.only(left: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                top: 2,
                bottom: 10,
                right: 10,
              ),
              child: Column(
                children: <Widget>[
                  movies[index].poster == null
                      ? Container(
                          width: 120,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Style.Colors.secondColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            shape: BoxShape.rectangle,
                          ),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                EvaIcons.filmOutline,
                                color: Colors.white,
                                size: 50,
                              )
                            ],
                          ),
                        )
                      : Container(
                          width: 120,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    "https://image.tmdb.org/t/p/w200/" +
                                        movies[index].poster),
                                fit: BoxFit.cover),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      movies[index].title,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        movies[index].rating.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      RatingBar(
                        itemSize: 8.0,
                        initialRating: movies[index].rating / 2,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2),
                        itemBuilder: (context, _) => Icon(
                          EvaIcons.star,
                          color: Style.Colors.secondColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
  }
}

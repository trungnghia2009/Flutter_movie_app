import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterappmovie/bloc/movies/get_movies_byGenre_bloc.dart';
import 'package:flutterappmovie/bloc/shows/get_shows_byGrenre_bloc.dart';
import 'package:flutterappmovie/model/shows/show_response.dart';
import 'package:flutterappmovie/widgets/utility_widgets.dart';
import '../../model/movies/movie_response.dart';
import '../../model/shows/show.dart';
import '../../style/theme.dart' as Style;

class ShowsByGenre extends StatefulWidget {
  final int genreId;
  ShowsByGenre({Key key, @required this.genreId}) : super(key: key);

  @override
  _ShowsByGenreState createState() => _ShowsByGenreState(genreId);
}

class _ShowsByGenreState extends State<ShowsByGenre> {
  final int genreId;
  _ShowsByGenreState(this.genreId);

  @override
  void initState() {
    super.initState();
    showsByGenreBloc..getShowsByGenre(genreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ShowResponse>(
      stream: showsByGenreBloc.subject.stream,
      builder: (context, AsyncSnapshot<ShowResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return utilityWidgets.buildErrorWidget(snapshot.data.error);
          }
          return _buildMoviesByGenre(snapshot.data);
        } else if (snapshot.hasError) {
          return utilityWidgets.buildErrorWidget(snapshot.error);
        } else {
          return utilityWidgets.buildLoadingWidget(270);
        }
      },
    );
  }

  Widget _buildMoviesByGenre(ShowResponse data) {
    List<Show> shows = data.shows;
    if (shows.length == 0) {
      return Container(
        child: Text('No Movies'),
      );
    } else
      return Container(
        height: 270,
        padding: EdgeInsets.only(left: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: shows.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 10,
              ),
              child: Column(
                children: <Widget>[
                  shows[index].poster == null
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                        shows[index].poster),
                                fit: BoxFit.cover),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      shows[index].title,
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
                        shows[index].rating.toString(),
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
                        initialRating: shows[index].rating / 2,
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

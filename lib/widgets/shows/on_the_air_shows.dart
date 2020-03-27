import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterappmovie/bloc/shows/get_on_the_air_shows_bloc.dart';
import 'package:flutterappmovie/model/shows/show.dart';
import 'package:flutterappmovie/model/shows/show_response.dart';
import 'package:flutterappmovie/widgets/utility_widgets.dart';
import '../../style/theme.dart' as Style;

class OnTheAirShows extends StatefulWidget {
  @override
  _OnTheAirShowsState createState() => _OnTheAirShowsState();
}

class _OnTheAirShowsState extends State<OnTheAirShows> {
  @override
  void initState() {
    super.initState();
    onTheAirShowsBloc..getShows();
  }

  @override
  Widget build(BuildContext context) {
    print('OnTheAirShows() build');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        utilityWidgets.buildTopTitle(
          title: "ON THE AIR TV SHOWS",
          onTap: () {
            // Navigate to all list
          },
        ),
        StreamBuilder<ShowResponse>(
          stream: onTheAirShowsBloc.subject.stream,
          builder: (context, AsyncSnapshot<ShowResponse> snapshot) {
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
        )
      ],
    );
  }

  Widget _buildTopMovieWidget(ShowResponse data) {
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
                top: 2,
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

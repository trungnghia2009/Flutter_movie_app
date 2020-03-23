import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/get_now_playing_bloc.dart';
import 'package:flutterappmovie/model/movie_response.dart';
import 'package:flutterappmovie/model/movie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_indicator/page_indicator.dart';
import '../style/theme.dart' as Style;
import '../widgets/utility_widgets.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    super.initState();
    nowPlayingMoviesBloc..getNowPlaying();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        utilityWidgets.buildTopTitle(
          title: "NOW PLAYING",
          onTap: () {
            //Navigate to all list
          },
        ),
        SizedBox(
          height: 2,
        ),
        StreamBuilder<MovieResponse>(
          stream: nowPlayingMoviesBloc.subject.stream,
          builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return utilityWidgets.buildErrorWidget(snapshot.data.error);
              }
              return _buildNowPlayingWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return utilityWidgets.buildErrorWidget(snapshot.error);
            } else {
              return utilityWidgets.buildLoadingWidget(220);
            }
          },
        ),
      ],
    );
  }

  Widget _buildNowPlayingWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('No movies'),
          ],
        ),
      );
    } else {
      return Container(
        height: 220,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          indicatorSpace: 8,
          indicatorColor: Style.Colors.titleColor,
          indicatorSelectorColor: Style.Colors.secondColor,
          padding: EdgeInsets.all(5),
          shape: IndicatorShape.circle(size: 8),
          pageView: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.take(5).length,
              itemBuilder: (context, index) {
                return Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              "https://image.tmdb.org/t/p/original" +
                                  movies[index].backPoster),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Style.Colors.mainColor.withOpacity(1.0),
                              Style.Colors.mainColor.withOpacity(0.0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.0, 0.9]),
                      ),
                    ),
                    Positioned(
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.playCircle,
                            color: Style.Colors.secondColor,
                            size: 40,
                          ),
                          onPressed: () {
                            print('Navigate to trailer');
                            //Navigate to trailer
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        width: 250,
                        child: Column(
                          children: <Widget>[
                            Text(
                              movies[index].title,
                              style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
          length: data.movies.take(5).length,
        ),
      );
    }
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/movies/get_now_playing_bloc.dart';
import 'package:flutterappmovie/bloc/movies/get_trailers_bloc.dart';
import 'package:flutterappmovie/model/movies/movie_response.dart';
import 'package:flutterappmovie/model/movies/movie.dart';
import 'package:flutterappmovie/model/trailer_response.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_indicator/page_indicator.dart';
import '../../style/theme.dart' as Style;
import '../utility_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

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
    print('NowPlaying() build');
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
              itemCount: movies.take(10).length,
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
                              "https://image.tmdb.org/t/p/w500" +
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
                            _buildTrailerDialog(data, index).then((_) {
                              // TODO: refresh Stream when beginning again
                              trailersBloc.drainStream();
                            });
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
          length: data.movies.take(10).length,
        ),
      );
    }
  }

  Future<void> _buildTrailerDialog(MovieResponse data, int index) {
    final controller = PageController();

    trailersBloc.getTrailers(data.movies[index].id);

    String _urlYoutube = "https://www.youtube.com/watch?v=";

    String _uTubeThumbnail(String key) {
      StringBuffer url = StringBuffer();
      url.write('https://img.youtube.com/vi/');
      url.write(key);
      url.write("/hqdefault.jpg");
      return url.toString();
    }

    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Style.Colors.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: StreamBuilder(
          stream: trailersBloc.subject.stream,
          builder: (context, AsyncSnapshot<TrailerResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return utilityWidgets.buildErrorWidget(snapshot.data.error);
              }
              return snapshot.data.trailers.length == 0
                  ? Container(
                      height: 250,
                      child: Center(
                        child: FlatButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            EvaIcons.filmOutline,
                            color: Style.Colors.titleColor,
                            size: 50,
                          ),
                          label: Text(
                            'No Trailers',
                            style: TextStyle(
                                color: Style.Colors.titleColor, fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: PageView.builder(
                        controller: controller,
                        onPageChanged: (value) {
                          print(value);
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.trailers.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 250,
                                decoration: BoxDecoration(),
                                child: CachedNetworkImage(
                                  imageUrl: _uTubeThumbnail(
                                      snapshot.data.trailers[index].key),
//                                    placeholder: (context, url) =>
//                                        SpinKitFadingCircle(
//                                      color: Style.Colors.secondColor,
//                                    ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/images/loading_error.jpg",
                                    height: 250,
                                  ),
                                ),
                              ),
                              Center(
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.playCircle,
                                    color: Style.Colors.secondColor,
                                    size: 35,
                                  ),
                                  onPressed: () async {
                                    final url = _urlYoutube +
                                        snapshot.data.trailers[index].key;
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    'Trailer #${index + 1}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 30,
                                        child: FloatingActionButton(
                                          backgroundColor:
                                              Style.Colors.mainColor,
                                          onPressed: () {
                                            controller.previousPage(
                                                duration:
                                                    Duration(milliseconds: 100),
                                                curve: Curves.linear);
                                          },
                                          child: Icon(
                                            Icons.chevron_left,
                                            size: 25,
                                            color: Style.Colors.secondColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 30,
                                        child: FloatingActionButton(
                                          backgroundColor:
                                              Style.Colors.mainColor,
                                          onPressed: () {
                                            controller.nextPage(
                                                duration:
                                                    Duration(milliseconds: 100),
                                                curve: Curves.linear);
                                          },
                                          child: Icon(
                                            Icons.chevron_right,
                                            size: 25,
                                            color: Style.Colors.secondColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
            } else if (snapshot.hasError) {
              return utilityWidgets.buildErrorWidget(snapshot.error);
            } else {
              return utilityWidgets.buildLoadingWidget(220);
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/shows/get_genres_bloc.dart';
import 'package:flutterappmovie/widgets/utility_widgets.dart';
import '../../model/genre_response.dart';
import '../../model/genre.dart';
import 'genres_list.dart';

class GenreShows extends StatefulWidget {
  @override
  _GenreShowsState createState() => _GenreShowsState();
}

class _GenreShowsState extends State<GenreShows> {
  @override
  void initState() {
    super.initState();
    genresBloc..getGenres();
  }

  @override
  Widget build(BuildContext context) {
    print('GenresScreen() build');
    return Column(
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        utilityWidgets.buildTopTitle(
          title: "GENRES",
          onTap: () {
            //Navigate to all list
          },
        ),
        StreamBuilder<GenreResponse>(
          stream: genresBloc.subject.stream,
          builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return utilityWidgets.buildErrorWidget(snapshot.data.error);
              }
              return _buildGenreWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return utilityWidgets.buildErrorWidget(snapshot.error);
            } else {
              return utilityWidgets.buildLoadingWidget(307);
            }
          },
        ),
      ],
    );
  }

  Widget _buildGenreWidget(GenreResponse data) {
    List<Genre> genres = data.genres;
    if (genres.length == 0) {
      return Container(
        child: Text('No genres'),
      );
    } else
      return GenresList(
        genres: genres,
      );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/get_genres_bloc.dart';
import 'package:flutterappmovie/widgets/utility_widgets.dart';
import '../model/genre_response.dart';
import '../model/genre.dart';
import '../widgets/genres_list.dart';

class GenresScreen extends StatefulWidget {
  @override
  _GenresScreenState createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  @override
  void initState() {
    super.initState();
    genresBloc..getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
      stream: genresBloc.subject.stream,
      builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return utilityWidgets.buildErrorWidget(snapshot.data.error);
          }
          return _buildGenreWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return utilityWidgets.buildErrorWidget(snapshot.error);
        } else {
          return utilityWidgets.buildLoadingWidget(307);
        }
      },
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

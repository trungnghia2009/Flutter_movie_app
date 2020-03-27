import 'package:flutter/cupertino.dart';
import 'package:flutterappmovie/model/movies/movie_response.dart';
import '../../repository/movies_repository.dart';
import 'package:rxdart/subjects.dart';

class MoviesListByGenreBloc {
  final MovieRepository _repository = MovieRepository();
  // TODO: BehaviorSubject assign type is MovieResponse
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMoviesByGenre(int id) async {
    MovieResponse response = await _repository.getMovieByGenre(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject {
    return _subject;
  }
}

final moviesByGenreBloc = MoviesListByGenreBloc();

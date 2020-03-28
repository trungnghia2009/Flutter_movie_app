import 'package:flutterappmovie/model/movies/movie_response.dart';
import 'package:flutterappmovie/repository/search_repository.dart';
import 'package:rxdart/subjects.dart';

class SearchMoviesListBloc {
  final SearchRepository _repository = SearchRepository();
  // TODO: BehaviorSubject assign type is MovieResponse
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovies(String query) async {
    print('getMovies...');
    MovieResponse response = await _repository.getMovies(query);
    _subject.sink.add(response);
  }

  drainStream() {
    _subject.value = null;
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject {
    return _subject;
  }
}

final searchMoviesBloc = SearchMoviesListBloc();

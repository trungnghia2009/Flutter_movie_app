import 'package:flutterappmovie/model/movie_response.dart';
import '../repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListBloc {
  final MovieRepository _repository = MovieRepository();
  // TODO: BehaviorSubject assign type is MovieResponse
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovies() async {
    MovieResponse response = await _repository.getMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject {
    return _subject;
  }
}

final moviesBloc = MoviesListBloc();

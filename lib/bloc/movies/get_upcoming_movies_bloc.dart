import 'package:flutterappmovie/model/movies/movie_response.dart';
import '../../repository/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

class UpcomingMoviesListBloc {
  final MovieRepository _repository = MovieRepository();
  // TODO: BehaviorSubject assign type is MovieResponse
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovies() async {
    MovieResponse response = await _repository.getUpcomingMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject {
    return _subject;
  }
}

final upcomingMoviesBloc = UpcomingMoviesListBloc();

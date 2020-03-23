import 'package:flutterappmovie/model/movie_response.dart';
import '../repository/repository.dart';
import 'package:rxdart/subjects.dart';

class NowPlayingListBloc {
  final MovieRepository _repository = MovieRepository();
  // TODO: BehaviorSubject assign type is MovieResponse
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getNowPlaying() async {
    MovieResponse response = await _repository.getPlayingMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject {
    return _subject;
  }
}

final nowPlayingMoviesBloc = NowPlayingListBloc();

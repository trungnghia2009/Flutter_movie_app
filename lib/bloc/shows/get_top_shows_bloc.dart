import 'package:flutterappmovie/model/movies/movie_response.dart';
import 'package:flutterappmovie/model/shows/show_response.dart';
import 'package:flutterappmovie/repository/shows_repository.dart';
import 'package:rxdart/rxdart.dart';

class TopShowsListBloc {
  final ShowRepository _repository = ShowRepository();
  // TODO: BehaviorSubject assign type is ShowResponse
  final BehaviorSubject<ShowResponse> _subject =
      BehaviorSubject<ShowResponse>();

  getShows() async {
    ShowResponse response = await _repository.getTopShows();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ShowResponse> get subject {
    return _subject;
  }
}

final topShowsBloc = TopShowsListBloc();

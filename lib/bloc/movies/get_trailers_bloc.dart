import 'package:flutterappmovie/model/trailer_response.dart';
import '../../repository/movies_repository.dart';
import 'package:rxdart/subjects.dart';

class TrailersListBloc {
  final MovieRepository _repository = MovieRepository();
  // TODO: BehaviorSubject assign type is TrailerResponse
  final BehaviorSubject<TrailerResponse> _subject =
      BehaviorSubject<TrailerResponse>();

  getTrailers(int id) async {
    TrailerResponse response = await _repository.getTrailerByMovie(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  void dispose() {
    _subject.close();
  }

  BehaviorSubject<TrailerResponse> get subject {
    return _subject;
  }
}

final trailersBloc = TrailersListBloc();

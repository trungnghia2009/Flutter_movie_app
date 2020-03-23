import 'package:flutterappmovie/model/genre_response.dart';
import '../repository/repository.dart';
import 'package:rxdart/subjects.dart';

class GenresListBloc {
  final MovieRepository _repository = MovieRepository();
  // TODO: BehaviorSubject assign type is GenreResponse
  final BehaviorSubject<GenreResponse> _subject =
      BehaviorSubject<GenreResponse>();

  getGenres() async {
    GenreResponse response = await _repository.getGenres();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject {
    return _subject;
  }
}

final genresBloc = GenresListBloc();

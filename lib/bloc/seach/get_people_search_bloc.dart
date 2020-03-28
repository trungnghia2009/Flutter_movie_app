import 'package:flutterappmovie/model/shows/show_response.dart';
import 'package:flutterappmovie/repository/search_repository.dart';
import 'package:rxdart/subjects.dart';

class SearchShowsListBloc {
  final SearchRepository _repository = SearchRepository();
  // TODO: BehaviorSubject assign type is ShowResponse
  final BehaviorSubject<ShowResponse> _subject =
      BehaviorSubject<ShowResponse>();

  getShows(String query) async {
    ShowResponse response = await _repository.getShows(query);
    _subject.sink.add(response);
  }

  drainStream() {
    _subject.value = null;
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ShowResponse> get subject {
    return _subject;
  }
}

final searchShowsBloc = SearchShowsListBloc();

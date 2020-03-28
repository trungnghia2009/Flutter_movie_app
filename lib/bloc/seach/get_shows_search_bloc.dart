import 'package:flutterappmovie/model/person_response.dart';
import 'package:flutterappmovie/repository/search_repository.dart';
import 'package:rxdart/subjects.dart';

class SearchPeopleListBloc {
  final SearchRepository _repository = SearchRepository();
  // TODO: BehaviorSubject assign type is MovieResponse
  final BehaviorSubject<PersonResponse> _subject =
      BehaviorSubject<PersonResponse>();

  getPeople(String query) async {
    PersonResponse response = await _repository.getPeople(query);
    _subject.sink.add(response);
  }

  drainStream() {
    _subject.value = null;
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject {
    return _subject;
  }
}

final searchPeopleBloc = SearchPeopleListBloc();

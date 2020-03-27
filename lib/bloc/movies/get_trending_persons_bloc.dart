import 'package:flutterappmovie/model/person_response.dart';
import '../../repository/movies_repository.dart';
import 'package:rxdart/subjects.dart';

class TrendingPersonsListBloc {
  final MovieRepository _repository = MovieRepository();
  // TODO: BehaviorSubject assign type is PersonResponse
  final BehaviorSubject<PersonResponse> _subject =
      BehaviorSubject<PersonResponse>();

  getPersons(String type) async {
    PersonResponse response = await _repository.getTrendingPersons(type);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject {
    return _subject;
  }
}

final trendingPersonsBloc = TrendingPersonsListBloc();

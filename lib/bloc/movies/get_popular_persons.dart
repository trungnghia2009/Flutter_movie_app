import 'package:flutterappmovie/model/person_response.dart';
import '../../repository/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

class PopularPersonsListBloc {
  final MovieRepository _repository = MovieRepository();
  // TODO: BehaviorSubject assign type is MovieResponse
  final BehaviorSubject<PersonResponse> _subject =
      BehaviorSubject<PersonResponse>();

  getPersons() async {
    PersonResponse response = await _repository.getPopularPersons();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject {
    return _subject;
  }
}

final popularPersonsBloc = PopularPersonsListBloc();

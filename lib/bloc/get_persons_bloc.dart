import 'package:flutterappmovie/model/person_response.dart';
import '../repository/repository.dart';
import 'package:rxdart/subjects.dart';

class PersonsListBloc {
  final MovieRepository _repository = MovieRepository();
  // TODO: BehaviorSubject assign type is PersonResponse
  final BehaviorSubject<PersonResponse> _subject =
      BehaviorSubject<PersonResponse>();

  getPersons() async {
    PersonResponse response = await _repository.getPersons();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject {
    return _subject;
  }
}

final personsBloc = PersonsListBloc();

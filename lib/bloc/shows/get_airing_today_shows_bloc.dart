import 'package:flutterappmovie/model/shows/show_response.dart';
import 'package:flutterappmovie/repository/shows_repository.dart';
import 'package:rxdart/subjects.dart';

class AiringTodayListBloc {
  final ShowRepository _repository = ShowRepository();
  // TODO: BehaviorSubject assign type is ShowResponse
  final BehaviorSubject<ShowResponse> _subject =
      BehaviorSubject<ShowResponse>();

  getAiringToday() async {
    ShowResponse response = await _repository.getAiringToday();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ShowResponse> get subject {
    return _subject;
  }
}

final airingTodayShowsBloc = AiringTodayListBloc();

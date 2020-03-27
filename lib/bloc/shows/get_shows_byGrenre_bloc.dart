import 'package:flutter/cupertino.dart';
import 'package:flutterappmovie/model/shows/show_response.dart';
import 'package:flutterappmovie/repository/shows_repository.dart';
import 'package:rxdart/subjects.dart';

class ShowsListByGenreBloc {
  final ShowRepository _repository = ShowRepository();
  // TODO: BehaviorSubject assign type is ShowResponse
  final BehaviorSubject<ShowResponse> _subject =
      BehaviorSubject<ShowResponse>();

  getShowsByGenre(int id) async {
    ShowResponse response = await _repository.getShowsByGenre(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<ShowResponse> get subject {
    return _subject;
  }
}

final showsByGenreBloc = ShowsListByGenreBloc();

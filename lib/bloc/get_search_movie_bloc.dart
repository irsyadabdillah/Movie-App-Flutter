import 'package:flutter/cupertino.dart';
import 'package:movie_app_flutter/models/movie_response.dart';
import 'package:rxdart/rxdart.dart';

import '../repository/repository.dart';

class SearchMovieBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getCasts(String query) async {
    MovieResponse response = await _repository.getSearchMovie(query);
    _subject.sink.add(response);
  }

  void drainStream() async {
    await _subject.drain();
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final searchMovieBloc = SearchMovieBloc();

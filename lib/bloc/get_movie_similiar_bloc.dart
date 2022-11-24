import 'package:flutter/cupertino.dart';
import 'package:movie_app_flutter/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../models/movie_response.dart';

class SimilarMoviesBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getSimilarMovies(int id) async {
    MovieResponse response = await _repository.getSimilarMovies(id);
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

final similarMoviesBloc = SimilarMoviesBloc();

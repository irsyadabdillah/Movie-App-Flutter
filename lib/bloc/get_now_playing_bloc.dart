import 'package:movie_app_flutter/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../models/movie_response.dart';

class NowPlayingBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovies() async {
    MovieResponse response = await _repository.getPlayingMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final nowPlayingMoviesBloc = NowPlayingBloc();

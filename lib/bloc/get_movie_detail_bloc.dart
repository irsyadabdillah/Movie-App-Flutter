import 'package:flutter/cupertino.dart';
import 'package:movie_app_flutter/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/movie_detail_response.dart';

class MovieDetailBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<MovieDetailResponse> _subject =
      BehaviorSubject<MovieDetailResponse>();

  getMovieDetail(int id) async {
    MovieDetailResponse response = await _repository.getMovieDetail(id);
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

  BehaviorSubject<MovieDetailResponse> get subject => _subject;
}

final movieDetailBloc = MovieDetailBloc();

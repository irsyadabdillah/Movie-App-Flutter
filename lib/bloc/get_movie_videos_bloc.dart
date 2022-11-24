import 'package:flutter/cupertino.dart';
import 'package:movie_app_flutter/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../models/video_response.dart';

class MovieVideosBloc {
  final Repository _repository = Repository();
  final BehaviorSubject<VideoResponse> _subject =
      BehaviorSubject<VideoResponse>();

  getMovieVideos(int id) async {
    VideoResponse response = await _repository.getMovieVideos(id);
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

  BehaviorSubject<VideoResponse> get subject => _subject;
}

final movieVideosBloc = MovieVideosBloc();

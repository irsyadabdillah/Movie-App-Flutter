import 'movie_detail.dart';

class MovieDetailResponse {
  final MovieDetail movieDetail;
  final String error;

  MovieDetailResponse(this.movieDetail, this.error);

  MovieDetailResponse.fromJson(Map<String, dynamic> json)
      : movieDetail = MovieDetail.fromJson(json),
        error = "";

  MovieDetailResponse.withError(String errorValue)
      : movieDetail = MovieDetail(0, false, 0, [], [], "", 0),
        error = errorValue;
}

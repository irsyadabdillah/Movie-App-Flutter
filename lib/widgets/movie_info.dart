import 'package:flutter/material.dart';
import 'package:movie_app_flutter/models/movie_detail.dart';
import 'package:movie_app_flutter/models/movie_detail_response.dart';
import 'package:movie_app_flutter/style/colors.dart';

import '../bloc/get_movie_detail_bloc.dart';

class MovieInfo extends StatefulWidget {
  final int id;
  const MovieInfo({super.key, required this.id});

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  void initState() {
    super.initState();
    movieDetailBloc.getMovieDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: movieDetailBloc.subject.stream,
      builder: ((context, AsyncSnapshot<MovieDetailResponse> snapshot) {
        if (snapshot.hasData) {
          return _buildSuccessWidget(snapshot.data!);
        } else {
          return _buildErrorWidget(snapshot.error as String);
        }
      }),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text("Error occured: $error"),
    );
  }

  Widget _buildSuccessWidget(MovieDetailResponse data) {
    MovieDetail detail = data.movieDetail;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${detail.runtime} min",
          style: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: black),
        ),
        Container(
          width: 1.5,
          height: 14.0,
          color: grey,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        ),
        Text(
          detail.releaseDate ?? "",
          style: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: black),
        ),
      ],
    );
  }
}

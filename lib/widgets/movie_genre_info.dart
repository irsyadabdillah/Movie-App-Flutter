import 'package:flutter/material.dart';
import 'package:movie_app_flutter/models/movie_detail.dart';
import 'package:movie_app_flutter/style/colors.dart';

import '../bloc/get_movie_detail_bloc.dart';
import '../models/movie_detail_response.dart';

class MovieGenreInfo extends StatefulWidget {
  final int id;
  const MovieGenreInfo({super.key, required this.id});

  @override
  State<MovieGenreInfo> createState() => _MovieGenreInfoState();
}

class _MovieGenreInfoState extends State<MovieGenreInfo> {
  @override
  void initState() {
    super.initState();
    movieDetailBloc.getMovieDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "GENRES",
          style: TextStyle(
              color: grey, fontWeight: FontWeight.w500, fontSize: 12.0),
        ),
        StreamBuilder(
          stream: movieDetailBloc.subject.stream,
          builder: ((context, AsyncSnapshot<MovieDetailResponse> snapshot) {
            if (snapshot.hasData) {
              return _buildSuccessWidget(snapshot.data!);
            } else {
              return _buildErrorWidget(snapshot.error as String);
            }
          }),
        )
      ]),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text("Error occured: $error"),
    );
  }

  Widget _buildSuccessWidget(MovieDetailResponse data) {
    MovieDetail detail = data.movieDetail;
    if ((detail.genres ?? []).isEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: const Text("No More Genres"),
      );
    } else {
      return Container(
        height: 40.0,
        padding: const EdgeInsets.only(top: 14.0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: (detail.genres ?? []).length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(
                          width: 1.0, color: black.withOpacity(0.6))),
                  child: Text(
                    (detail.genres![index]).name ?? "",
                    maxLines: 1,
                    style: const TextStyle(
                        height: 1.4,
                        color: black,
                        fontWeight: FontWeight.w600,
                        fontSize: 9.0),
                  ),
                ),
              );
            }),
      );
    }
  }
}

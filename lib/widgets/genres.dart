import 'package:flutter/material.dart';
import 'package:movie_app_flutter/models/genre_response.dart';
import 'package:movie_app_flutter/style/colors.dart';
import 'package:shimmer/shimmer.dart';
import '../bloc/get_genres_bloc.dart';
import '../models/genre.dart';
import 'genres_list.dart';

class Genres extends StatefulWidget {
  const Genres({super.key});

  @override
  State<Genres> createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  @override
  void initState() {
    super.initState();
    genresBloc.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: genresBloc.subject.stream,
        builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
          if (snapshot.hasData) {
            // return _buildLoadingWidget();
            return _buildSuccessWidget(snapshot.data!);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error as String);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget _buildLoadingWidget() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Shimmer.fromColors(
            baseColor: grey.withOpacity(0.3),
            highlightColor: grey.withOpacity(0.1),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 14.0, bottom: 4.0, left: 14.0),
                  child: Container(
                    width: 120,
                    decoration: const BoxDecoration(
                      color: white,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 260.0,
          child: Shimmer.fromColors(
            baseColor: grey.withOpacity(0.3),
            highlightColor: grey.withOpacity(0.1),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: 120,
                        height: 14,
                        decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text("Error occured: $error"),
    );
  }

  Widget _buildSuccessWidget(GenreResponse data) {
    List<Genre> genres = data.genres;
    return GenresList(
      genres: genres,
    );
  }
}

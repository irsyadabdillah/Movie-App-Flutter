import 'package:flutter/material.dart';
import 'package:movie_app_flutter/models/genre_response.dart';
import 'package:movie_app_flutter/style/colors.dart';
import '../bloc/get_genres_bloc.dart';
import '../models/genre.dart';
import 'genres_list.dart';
import 'dart:convert';

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
            return _buildSuccessWidget(snapshot.data!);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error as String);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            // ignore: prefer_const_constructors, unnecessary_new
            valueColor: new AlwaysStoppedAnimation<Color>(black),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildSuccessWidget(GenreResponse data) {
    List<Genre> genres = data.genres;
    return GenresList(
      genres: genres,
    );
  }
}

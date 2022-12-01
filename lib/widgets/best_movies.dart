import 'package:movie_app_flutter/bloc/get_movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_flutter/models/movie_response.dart';
import 'package:movie_app_flutter/style/colors.dart';

import '../models/movie.dart';

class BestMovies extends StatefulWidget {
  const BestMovies({super.key});

  @override
  State<BestMovies> createState() => _BestMoviesState();
}

class _BestMoviesState extends State<BestMovies> {
  @override
  void initState() {
    super.initState();
    moviesBloc.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 10.0, top: 0.0),
          child: Text(
            "POPULAR MOVIES",
            style: TextStyle(
                color: black, fontWeight: FontWeight.bold, fontSize: 12.0),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        StreamBuilder(
          stream: moviesBloc.subject.stream,
          builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
            if (snapshot.hasData) {
              return _buildSuccessWidget(snapshot.data!);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error as String);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
    );
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

  Widget _buildSuccessWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    return Container(
      height: 260.0,
      padding: const EdgeInsets.only(left: 10.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if ((movies[index].poster ?? "").isEmpty)
                      Container(
                        width: 120.0,
                        height: 180.0,
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                          color: grey.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          shape: BoxShape.rectangle,
                        ),
                      )
                    else
                      Container(
                        width: 120.0,
                        height: 180.0,
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                            color: grey.withOpacity(0.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w200/${movies[index].poster}"))),
                      ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        movies[index].title ?? "",
                        maxLines: 2,
                        style: const TextStyle(
                            height: 1.4, color: black, fontSize: 11.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app_flutter/bloc/get_movies_by_genre_bloc.dart';
import 'package:movie_app_flutter/models/movie.dart';
import 'package:movie_app_flutter/models/movie_response.dart';
import 'package:movie_app_flutter/screens/detail_screen.dart';
import 'package:movie_app_flutter/style/colors.dart';
import 'package:shimmer/shimmer.dart';

class GenreMovies extends StatefulWidget {
  final int genreId;
  const GenreMovies({Key? key, required this.genreId}) : super(key: key);

  @override
  State<GenreMovies> createState() => _GenreMoviesState();
}

class _GenreMoviesState extends State<GenreMovies> {
  @override
  void initState() {
    super.initState();
    moviesByGenreBloc.getMoviesByGenre(widget.genreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: moviesByGenreBloc.subject.stream,
      builder: ((context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          // return _buildLoadingWidget();
          return _buildSuccessWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error as String);
        } else {
          return _buildLoadingWidget();
        }
      }),
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      height: 260.0,
      child: Shimmer.fromColors(
        baseColor: grey.withOpacity(0.3),
        highlightColor: grey.withOpacity(0.1),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 14.0),
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
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text("Error occured: $error"),
    );
  }

  Widget _buildSuccessWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    return SizedBox(
      height: 260.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 14.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(movie: movies[index])));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ((movies[index].poster ?? "").isEmpty)
                      Container(
                        width: 120.0,
                        height: 180.0,
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

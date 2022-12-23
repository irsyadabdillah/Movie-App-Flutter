import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app_flutter/bloc/get_search_movie_bloc.dart';
import 'package:movie_app_flutter/style/colors.dart';

import '../models/movie.dart';
import '../models/movie_response.dart';
import '../screens/detail_screen.dart';

class SearchMovie extends StatefulWidget {
  final String query;
  const SearchMovie({super.key, required this.query});

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  @override
  void didUpdateWidget(covariant SearchMovie oldWidget) {
    super.didUpdateWidget(oldWidget);
    searchMovieBloc.getSearchMovie(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: searchMovieBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          return _buildSuccessWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error as String);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text("Error occured: $error"),
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorImage() {
    return Stack(
      children: [
        Container(
          width: 80.0,
          height: 120.0,
          decoration: BoxDecoration(
            color: grey.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            shape: BoxShape.rectangle,
          ),
        ),
        const Positioned(
          bottom: 0.0,
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: Icon(
            Icons.broken_image_rounded,
            color: maroon,
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 14.0, right: 14.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(movie: movies[index])));
                },
                child: Stack(
                  children: [
                    Container(
                      height: 120.0,
                      decoration: BoxDecoration(
                        color: grey.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((movies[index].poster ?? "").isEmpty)
                          _buildErrorImage()
                        else
                          Container(
                            width: 80.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                                color: grey.withOpacity(0.1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w200/${movies[index].poster}"))),
                          ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                movies[index].title ?? "",
                                maxLines: 2,
                                style: const TextStyle(
                                    color: black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                movies[index].releaseDate ?? "",
                                style: const TextStyle(
                                  height: 2.0,
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),
                              RatingBar(
                                itemSize: 14.0,
                                ratingWidget: RatingWidget(
                                  empty: const Icon(
                                    Icons.star,
                                    color: grey,
                                  ),
                                  full: const Icon(
                                    Icons.star,
                                    color: maroon,
                                  ),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: maroon,
                                  ),
                                ),
                                initialRating: movies[index].rating! / 2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                onRatingUpdate: (rating) {},
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

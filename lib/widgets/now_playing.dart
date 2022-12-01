import 'package:flutter/material.dart';
import 'package:movie_app_flutter/bloc/get_now_playing_bloc.dart';
import 'package:movie_app_flutter/models/movie_response.dart';
import 'package:movie_app_flutter/style/colors.dart';
import 'package:page_indicator/page_indicator.dart';

import '../models/movie.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    super.initState();
    nowPlayingMoviesBloc.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: nowPlayingMoviesBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
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

  Widget _buildSuccessWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    return SizedBox(
      height: 220.0,
      child: PageIndicatorContainer(
        align: IndicatorAlign.bottom,
        length: movies.take(5).length,
        indicatorSpace: 6.0,
        padding: const EdgeInsets.only(bottom: 14.0),
        indicatorColor: grey,
        indicatorSelectorColor: maroon,
        shape: IndicatorShape.circle(size: 6.0),
        child: PageView.builder(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          itemCount: movies.take(5).length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: movies[index].id ?? 0,
                    child: Container(
                      height: 220.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/original/${movies[index].backPoster}")),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [
                            0.0,
                            0.9
                          ],
                          colors: [
                            black.withOpacity(1.0),
                            black.withOpacity(0.0)
                          ]),
                    ),
                  ),
                  const Positioned(
                    bottom: 0.0,
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Icon(
                      Icons.play_circle_fill_rounded,
                      color: maroon,
                      size: 60.0,
                    ),
                  ),
                  Positioned(
                      bottom: 30.0,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        width: 250.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              movies[index].title ?? "",
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  height: 1.5,
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app_flutter/bloc/get_movie_videos_bloc.dart';
import 'package:movie_app_flutter/models/movie.dart';
import 'package:movie_app_flutter/style/colors.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    MovieVideosBloc().getMovieVideos(widget.movie.id);
  }

  @override
  void dispose() {
    super.dispose();
    movieVideosBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: white,
            iconTheme: const IconThemeData(color: black),
            elevation: 0,
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.movie.title.length > 40
                    ? "${widget.movie.title.substring(0, 37)}..."
                    : widget.movie.title,
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: black),
              ),
              background: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://image.tmdb.org/t/p/original/${widget.movie.backPoster}"),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(color: black.withOpacity(0.5)),
                    ),
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
                            white.withOpacity(1.0),
                            white.withOpacity(0.0)
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(0.0),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.yellow),
                    Text(
                      widget.movie.rating.toString(),
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                    Container(
                      width: 1.0,
                      height: 14.0,
                      color: grey,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    const Text("Movie Name")
                  ],
                ),
              )
            ])),
          )
        ],
      ),
    );
  }
}

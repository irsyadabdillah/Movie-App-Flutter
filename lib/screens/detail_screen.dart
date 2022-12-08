import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_flutter/bloc/get_movie_videos_bloc.dart';
import 'package:movie_app_flutter/models/movie.dart';
import 'package:movie_app_flutter/style/colors.dart';
import 'package:movie_app_flutter/widgets/cast_info.dart';
import 'package:movie_app_flutter/widgets/movie_genre_info.dart';
import 'package:movie_app_flutter/widgets/movie_info.dart';

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
    movieVideosBloc.getMovieVideos(widget.movie.id ?? 0);
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
            iconTheme: const IconThemeData(color: maroon),
            elevation: 0,
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                (widget.movie.title ?? "").length > 40
                    ? "${widget.movie.title?.substring(0, 37)}..."
                    : widget.movie.title ?? "",
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: maroon),
              ),
              background: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://image.tmdb.org/t/p/original/${widget.movie.backPoster}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            fit: BoxFit.cover, image: imageProvider),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
                    const Icon(Icons.star, color: maroon),
                    Text(
                      widget.movie.rating.toString(),
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: maroon),
                    ),
                    Container(
                      width: 1.5,
                      height: 14.0,
                      color: grey,
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    ),
                    MovieInfo(id: widget.movie.id ?? 0)
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 14.0, top: 20.0),
                child: Text(
                  "OVERVIEW",
                  style: TextStyle(
                      color: grey, fontWeight: FontWeight.w500, fontSize: 12.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 14.0, right: 14.0, top: 14.0),
                child: Text(
                  widget.movie.overview ?? "",
                  style: const TextStyle(color: black, fontSize: 12.0),
                ),
              ),
              MovieGenreInfo(id: widget.movie.id ?? 0),
              CastInfo(id: widget.movie.id ?? 0)
            ])),
          )
        ],
      ),
    );
  }
}

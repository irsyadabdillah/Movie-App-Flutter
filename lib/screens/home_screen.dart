import 'package:flutter/material.dart';
import 'package:movie_app_flutter/style/colors.dart';
import 'package:movie_app_flutter/widgets/best_movies.dart';
import 'package:movie_app_flutter/widgets/genres.dart';
import 'package:movie_app_flutter/widgets/now_playing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(color: black),
        ),
      ),
      body: ListView(
        children: const <Widget>[
          NowPlaying(),
          Genres(),
          BestMovies(),
        ],
      ),
    );
  }
}

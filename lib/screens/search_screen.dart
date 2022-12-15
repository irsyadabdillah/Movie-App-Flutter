import 'package:flutter/material.dart';
import 'package:movie_app_flutter/style/colors.dart';
import 'package:movie_app_flutter/widgets/search_movie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        centerTitle: true,
        title: const Text(
          "Setting",
          style: TextStyle(color: black),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(right: 24.0, left: 24.0),
        child: TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          onChanged: (text) {
            setState(() {});
          },
          onSubmitted: (value) {
            SearchMovie(query: value);
          },
          cursorColor: maroon,
          decoration: InputDecoration(
              hintText: "Search Movie",
              hintStyle: TextStyle(color: grey.withOpacity(0.5)),
              prefixIcon: const Icon(
                Icons.search_outlined,
                color: grey,
              ),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _controller.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.clear, color: grey))
                  : null,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: maroon, width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: maroon, width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)),
        ),
      ),
    );
  }
}

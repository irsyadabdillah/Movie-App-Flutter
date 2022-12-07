import 'package:flutter/material.dart';
import 'package:movie_app_flutter/bloc/get_casts_bloc.dart';
import 'package:movie_app_flutter/style/colors.dart';

import '../models/cast.dart';
import '../models/cast_response.dart';

class CastInfo extends StatefulWidget {
  final int id;
  const CastInfo({super.key, required this.id});

  @override
  State<CastInfo> createState() => _CastInfoState();
}

class _CastInfoState extends State<CastInfo> {
  @override
  void initState() {
    super.initState();
    castsBloc.getCasts(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 14.0, top: 20.0),
          child: Text(
            "CASTS",
            style: TextStyle(
                color: grey, fontWeight: FontWeight.w500, fontSize: 12.0),
          ),
        ),
        StreamBuilder(
            stream: castsBloc.subject.stream,
            builder: (context, AsyncSnapshot<CastResponse> snapshot) {
              if (snapshot.hasData) {
                return _buildSuccessWidget(snapshot.data!);
              } else {
                return _buildErrorWidget(snapshot.error as String);
              }
            })
      ],
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text("Error occured: $error"),
    );
  }

  Widget _buildSuccessWidget(CastResponse data) {
    List<Cast> casts = data.casts;
    if (casts.isEmpty) {
      return Container(
        margin: const EdgeInsets.only(left: 14.0, top: 10.0),
        child: const Text("No More Persons"),
      );
    } else {
      return SizedBox(
        height: 140.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: casts.length,
            itemBuilder: (context, index) {
              return Container(
                width: 80.0,
                margin: const EdgeInsets.only(left: 14.0, top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (casts[index].img == null)
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: grey),
                        child: const Icon(
                          Icons.person,
                          color: white,
                        ),
                      )
                    else
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: grey,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w300/${casts[index].img}"))),
                      ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      casts[index].name ?? "",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: const TextStyle(
                          height: 1.4,
                          color: maroon,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.0),
                    ),
                    Text(
                      casts[index].character ?? "",
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          height: 1.4,
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 7.0),
                    ),
                  ],
                ),
              );
            }),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id, posterPath;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
    required this.posterPath,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.transparent,
        image: DecorationImage(
          image: NetworkImage(widget.posterPath),
          fit: BoxFit.cover,
          opacity: 0.7,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          flexibleSpace: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 50, top: 46),
            child: Text(
              "Back to list",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
              ),
              Text(widget.title,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(0, 0),
                        blurRadius: 15,
                      ),
                    ],
                  )),
              FutureBuilder(
                future: movie,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: makeRate(snapshot.data!.rate),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // for (var genre in snapshot.data!.genres) Text(genre),
                        Text(
                          '${snapshot.data!.runtime} | ${snapshot.data!.genres}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 0),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Storyline',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 0),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          snapshot.data!.overview,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 0),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> makeRate(double rate) {
    int totalStars = 5;
    int filledStarts = rate ~/ 2;
    bool halfStar = (rate % 1) >= 0.5;
    List<Widget> stars = [];

    for (int i = 0; i < filledStarts; i++) {
      stars.add(Icon(Icons.star, color: Colors.amber));
    }
    if (halfStar) {
      stars.add(Icon(Icons.star_half, color: Colors.amber));
      totalStars -= 1;
    }
    for (int i = 0; i < totalStars - filledStarts; i++) {
      stars.add(Icon(Icons.star_border, color: Colors.amber));
    }
    return stars;
  }
}

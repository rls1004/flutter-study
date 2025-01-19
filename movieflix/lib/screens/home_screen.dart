import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/widgets/movie_widget.dart';

enum filterType {
  all,
  playing,
  coming,
  animation,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  filterType ft = filterType.all;

  final Future<Map<String, List<MovieModel>>> allMovies =
      ApiService.getAllMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Movie Buff',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Frames that never overflow',
                  style: Theme.of(context).textTheme.titleSmall,
                  softWrap: true,
                ),
              ],
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: allMovies,
        builder: (context, future) {
          if (future.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  // for (var movies in future.data!.entries)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: makeFilterBtn(future, context),
                      ),
                      SizedBox(
                        height: 290,
                        child: makeList(
                            future.data!.entries.elementAt(ft.index).key,
                            future.data!.entries.elementAt(ft.index).value),
                      ),
                    ],
                  ),

                  for (var movies in future.data!.entries.skip(3))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            movies.key,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        SizedBox(
                          height: 270,
                          child: makeList(
                            movies.key,
                            movies.value,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Row makeFilterBtn(AsyncSnapshot<Map<String, List<MovieModel>>> future,
      BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Buzzing Now",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          width: 40,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              ft = filterType.all;
            });
          },
          child: Text(
            'All',
            style: TextStyle(
              fontSize: 12,
              fontWeight:
                  ft == filterType.all ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
        Text(
          '|',
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              ft = filterType.playing;
            });
          },
          child: Text(
            'Playing',
            style: TextStyle(
              fontSize: 12,
              fontWeight:
                  ft == filterType.playing ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
        Text(
          '|',
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              ft = filterType.coming;
            });
          },
          child: Text(
            'Coming',
            style: TextStyle(
              fontSize: 12,
              fontWeight:
                  ft == filterType.coming ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  ListView makeList(String kind, List<MovieModel> future) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      scrollDirection: Axis.horizontal,
      itemCount: future.length,
      itemBuilder: (context, index) {
        var movie = future[index];
        return Stack(
          children: [
            Movie(
                title: movie.title,
                thumb: movie.thumb,
                id: movie.id,
                posterPath: movie.posterPath,
                width: ['Popular Movies', 'Now in Cinemas', 'Coming soon']
                        .contains(kind)
                    ? 250
                    : 230),
            if (kind == 'Popular Movies' || true)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: SizedBox(
                  width: 200,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}

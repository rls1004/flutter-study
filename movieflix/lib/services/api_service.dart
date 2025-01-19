import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/models/movie_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String playing = "now-playing";
  static const String coming = "coming-soon";
  static const String detail = "movie?id=";

  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movieInstances = [];

    final url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        movieInstances.add(MovieModel.fromJson(movie));
      }

      movieInstances.sort((a, b) => b.rate.compareTo(a.rate));

      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getPlayingMovies() async {
    List<MovieModel> movieInstances = [];

    final url = Uri.parse('$baseUrl/$playing');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      movieInstances.sort((a, b) => b.rate.compareTo(a.rate));
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getComingMovies() async {
    List<MovieModel> movieInstances = [];

    final url = Uri.parse('$baseUrl/$coming');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      movieInstances.sort((a, b) => b.rate.compareTo(a.rate));

      return movieInstances;
    }
    throw Error();
  }

  static Future<Map<String, List<MovieModel>>> getAllMovies() async {
    var popularMovies = await getPopularMovies();
    var playingMovies = await getPlayingMovies();
    var comingMovies = await getComingMovies();

    comingMovies.removeWhere(
        (mv1) => playingMovies.any((mv2) => mv1.title == mv2.title));

    Map<String, List<MovieModel>> movieModelInstances = {
      'Popular Movies': popularMovies,
      'Now in Cinemas': playingMovies,
      'Coming soon': comingMovies,
      'Animation': getMoviesByGenre(16, popularMovies),
      'Romance': getMoviesByGenre(10749, popularMovies),
      'Horror': getMoviesByGenre(27, popularMovies),
    };

    return movieModelInstances;
  }

  static List<MovieModel> getMoviesByGenre(
      int genreId, List<MovieModel> movies) {
    List<MovieModel> genreMovies = [];
    for (var movie in movies) {
      if (movie.genreIds.contains(genreId)) {
        genreMovies.add(movie);
      }
    }

    return genreMovies;
  }

  static Future<MovieDetailModel> getMovieById(String id) async {
    const String baseUrl =
        "https://movies-api.nomadcoders.workers.dev/movie?id=";

    final url = Uri.parse('$baseUrl$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      return (MovieDetailModel.fromJson(movie));
    }
    throw Error();
  }
}

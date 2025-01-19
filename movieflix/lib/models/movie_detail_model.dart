class MovieDetailModel {
  late String posterPath, title, runtime, genres, overview;
  late double rate;

  MovieDetailModel.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path'];

    title = json['original_title'];
    rate = json['vote_average'] + 0.0;

    var runtimeMin = json['runtime'];
    runtime = '${runtimeMin ~/ 60}h ${runtimeMin % 60}min';

    var genresData = json['genres'];
    genres = '';
    for (var object in genresData) {
      if (genres.isNotEmpty) {
        genres += ", ${object['name']}";
      } else {
        genres += "${object['name']}";
      }
    }

    overview = json['overview'];

    print(rate);
  }
}

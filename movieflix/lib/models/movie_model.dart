class MovieModel {
  late String title, thumb, id, posterPath;
  late double rate;
  List<num> genreIds = [];

  MovieModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumb = "https://image.tmdb.org/t/p/w500${json['backdrop_path']}";
    id = json['id'].toString();
    posterPath = "https://image.tmdb.org/t/p/w500${json['poster_path']}";
    rate = json['vote_average'] + 0.0;

    genreIds.addAll((json['genre_ids'] as List<dynamic>).cast<int>());
  }
}

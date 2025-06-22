import 'package:get/get.dart';

class MoviesModel {
  bool adult = false;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool video = false;
  double? voteAverage;
  int? voteCount;
  RxBool isFavourite = false.obs;

  MoviesModel({
    this.adult = false,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video = false,
    this.voteAverage,
    this.voteCount,
  });

  MoviesModel.fromJson(Map json) {
    adult = json['adult'] ?? false;
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'] ?? false;
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
}

import 'package:cinema_app/constants/api%20constants/movie_key_constants.dart';
import 'package:cinema_app/utils/shared/conversion.dart';

class MovieModel {
  final bool isAdult;
  final String ? backdropPathImage;
  final List<int> genreIds;
  final int movieId;
  final String movieTitle;
  final String originalLanguage;
  final String overview;
  final String ? posterPathImage;
  final DateTime releaseDate;
  final double voteAverage;

  MovieModel({
    required this.isAdult,
    required this.backdropPathImage,
    required this.genreIds,
    required this.movieId,
    required this.movieTitle,
    required this.originalLanguage,
    required this.overview,
    required this.posterPathImage,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json){
    return MovieModel(
        isAdult: json[MovieKeyConstants.adult],
        backdropPathImage: json[MovieKeyConstants.backdropPath],
        genreIds: (json[MovieKeyConstants.genreIds] as List<dynamic>).map((element)=>element as int).toList(),
        movieId: json[MovieKeyConstants.id],
        movieTitle: json[MovieKeyConstants.title],
        originalLanguage: json[MovieKeyConstants.originalLanguage],
        overview: json[MovieKeyConstants.overview],
        posterPathImage: json[MovieKeyConstants.posterPath],
        releaseDate: Conversion.convertStringToDateTime(json[MovieKeyConstants.releaseDate]),
        voteAverage: (json[MovieKeyConstants.voteAverage] as num).toDouble()
    );
  }
}

import 'package:cinema_app/data/models/company_model.dart';
import 'package:cinema_app/data/models/genre_model.dart';
import 'package:cinema_app/utils/shared/conversion.dart';

import '../../constants/api constants/movie_key_constants.dart';

class DetailsMovieModel {
  final bool isAdult;
  final String backdropPathImage;
  final List<GenreModel> genres;
  final int movieId;
  final String movieTitle;
  final String originalLanguage;
  final String overview;
  final String posterPathImage;
  final DateTime releaseDate;
  final double voteAverage;
  final String imdbId;
  final int runTime;
  final String status;
  final String tagLine;
  final List<String> originCountry;
  final List<CompanyModel> productionCompanies;

  DetailsMovieModel({
    required this.isAdult,
    required this.backdropPathImage,
    required this.genres,
    required this.movieId,
    required this.movieTitle,
    required this.originalLanguage,
    required this.overview,
    required this.posterPathImage,
    required this.releaseDate,
    required this.voteAverage,
    required this.imdbId,
    required this.runTime,
    required this.status,
    required this.tagLine,
    required this.originCountry,
    required this.productionCompanies,
  });

  factory DetailsMovieModel.fromJson(Map<String, dynamic> json){
    return DetailsMovieModel(
        isAdult: json[MovieKeyConstants.adult],
        backdropPathImage: json[MovieKeyConstants.backdropPath],
        genres: (json[MovieKeyConstants.genres] as List<dynamic>)
            .map((genre)=>GenreModel.fromJson(genre)).toList()
        ,
        movieId: json[MovieKeyConstants.id],
        movieTitle: json[MovieKeyConstants.title],
        originalLanguage: json[MovieKeyConstants.originalLanguage],
        overview: json[MovieKeyConstants.overview],
        posterPathImage: json[MovieKeyConstants.posterPath],
        releaseDate: Conversion.convertStringToDateTime(json[MovieKeyConstants.releaseDate]),
        voteAverage: (json[MovieKeyConstants.voteAverage] as num).toDouble(),
        imdbId: json[MovieKeyConstants.imdbId],
        runTime: json[MovieKeyConstants.runTime],
        status: json[MovieKeyConstants.status],
        tagLine: json[MovieKeyConstants.tagLine],
        originCountry: json[MovieKeyConstants.originCountry],
        productionCompanies: (json[MovieKeyConstants.productionCompanies] as List<dynamic>)
            .map((company) => CompanyModel.fromJson(company)).toList(),
    );
  }

}

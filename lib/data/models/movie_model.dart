import 'package:cinema_app/constants/api%20constants/movie_key_constants.dart';
import 'package:cinema_app/data/models/company_model.dart';
import 'package:cinema_app/data/models/genre_model.dart';
import 'package:cinema_app/utils/shared/conversion.dart';

class MovieModel {
  final bool isAdult;
  final String ? backdropPathImage;
  final List<int> ?genreIds;
  final int movieId;
  final String movieTitle;
  final String originalLanguage;
  final String overview;
  final String ? posterPathImage;
  final DateTime releaseDate;
  final double voteAverage;
  final String? imdbId;
  final int ?runTime;
  final String ?status;
  final String ?tagLine;
  final List<String> ?originCountry;
  final List<CompanyModel>? productionCompanies;
  final List<GenreModel>? genres;


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
    required this.genres,
    required this.imdbId,
    required this.runTime,
    required this.status,
    required this.tagLine,
    required this.originCountry,
    required this.productionCompanies,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json){
    return MovieModel(
        isAdult: json[MovieKeyConstants.adult],
        backdropPathImage: json[MovieKeyConstants.backdropPath],
        genreIds: (json[MovieKeyConstants.genreIds] == null)? null :(json[MovieKeyConstants.genreIds] as List<dynamic>).map((element)=>element as int).toList(),
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
        originCountry: (json[MovieKeyConstants.originCountry] == null) ? null :(json[MovieKeyConstants.originCountry] as List<dynamic>)
            .map((element)=>element as String).toList()
        ,
        productionCompanies: (json[MovieKeyConstants.productionCompanies] == null)? null :(json[MovieKeyConstants.productionCompanies] as List<dynamic>)
            .map((company) => CompanyModel.fromJson(company)).toList(),
        genres: (json[MovieKeyConstants.genres] == null)?null:(json[MovieKeyConstants.genres] as List<dynamic>)
            .map((genre)=>GenreModel.fromJson(genre)).toList()
        ,
    );
  }
}

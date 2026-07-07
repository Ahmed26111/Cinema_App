import 'dart:developer';

import 'package:cinema_app/constants/api%20constants/api_constants.dart';
import 'package:cinema_app/constants/movie%20genre%20enum/movie_genre_enum.dart';
import 'package:cinema_app/data/models/cast_model.dart';
import 'package:cinema_app/data/models/movie/movie_model.dart';
import 'package:cinema_app/data/services/dio_helper.dart';
import 'package:cinema_app/utils/shared/conversion.dart';

class MovieRepository{
  final DioHelper dioHelper;

  MovieRepository({required this.dioHelper});

  Future<List<MovieModel>> getPopularMovies() async {
    var response = await dioHelper.getData(path: ApiConstants.moviePopularEndPoint , query: {"api_key":ApiConstants.apiKey});
    if(response.statusCode == 200 || response.statusCode == 304){
      List<dynamic> results = response.data["results"];
      return results.map((movie)=>MovieModel.fromJson(movie)).toList();
    }
    else{
      throw Exception("Failed to get the popular movies");
    }
  }
  Future<List<MovieModel>> getPopularMoviesByGenre(MovieGenreEnum genre) async {
    // Use genreID check instead of instance check
    if (genre.genreID == -1) {
      return getPopularMovies();
    }

    var response = await dioHelper.getData(
      path: ApiConstants.discoverMovieEndPoint,
      query: {
        "api_key": ApiConstants.apiKey.trim(), // Safety trim
        "sort_by": ApiConstants.popularDescending,
        "with_genres": genre.genreID
      },
    );
    if (response.statusCode == 200 || response.statusCode == 304) {
      List<dynamic> results = response.data["results"];
      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception("Failed to get the popular movies by genre");
    }
  }
  Future<List<MovieModel>> getTopRatedMoviesByGenre(MovieGenreEnum genre) async {
    if (genre.genreID == -1) {
      return getTopRatedMovies();
    }
    var response = await dioHelper.getData(
        path: ApiConstants.discoverMovieEndPoint,
        query: {
          "api_key": ApiConstants.apiKey,
          "sort_by": ApiConstants.topRatedDescending,
          "with_genres": genre.genreID
        });
    if (response.statusCode == 200 || response.statusCode == 304) {
      List<dynamic> results = response.data["results"];
      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    else {
      throw Exception("Failed to get the top rated movies by genre");
    }
  }
  Future<List<MovieModel>> getUpComingMoviesByGenre(MovieGenreEnum genre) async {
    if (genre.genreID == -1) {
      return getPopularMovies();
    }
    var response = await dioHelper.getData(
        path: ApiConstants.discoverMovieEndPoint,
        query: {
          "api_key": ApiConstants.apiKey,
          "sort_by": ApiConstants.upComingDescending,
          "with_genres": genre.genreID,
          "primary_release_date.gte": Conversion.today()
        });
    if (response.statusCode == 200 || response.statusCode == 304) {
      List<dynamic> results = response.data["results"];
      return results.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    else {
      throw Exception("Failed to get the upcoming movies by genre");
    }
  }
  Future<List<MovieModel>> getTopRatedMovies() async {
    var response = await dioHelper.getData(path: ApiConstants.movieTopRatedEndPoint, query: {"api_key":ApiConstants.apiKey});
    if(response.statusCode == 200 || response.statusCode == 304){
      List<dynamic> results = response.data["results"];
      return results.map((movie)=>MovieModel.fromJson(movie)).toList();
    }
    else{
      throw Exception("Failed to get the top rated movies");
    }
  }
  Future<List<MovieModel>> getUpComingMovies() async {
    var response = await dioHelper.getData(path: ApiConstants.movieUpComingEndPoint, query: {"api_key":ApiConstants.apiKey});
    if(response.statusCode == 200 || response.statusCode == 304){
      List<dynamic> results = response.data["results"];
      return results.map((movie)=>MovieModel.fromJson(movie)).toList();
    }
    else{
      throw Exception("Failed to get the upcoming movies");
    }
  }
  Future<MovieModel> getDetailsMovieById(int movieId) async {
      var response = await dioHelper.getData(path: ApiConstants.movieIdEndPoint + movieId.toString(), query: {"api_key":ApiConstants.apiKey});
      if(response.statusCode == 200 || response.statusCode == 304){
        dynamic result = response.data;
        return MovieModel.fromJson(result);
      }
      else{
        throw Exception("Failed to get movie details");
      }
  }
  Future<List<MovieModel>> getMoviesBySearch(String searchQuery) async {
    var response = await dioHelper.getData(path: ApiConstants.searchMovieEndPoint, query: {"api_key":ApiConstants.apiKey , "query":searchQuery});
    if(response.statusCode == 200 || response.statusCode == 304){
      List<dynamic> results = response.data["results"];
      return results.map((movie)=>MovieModel.fromJson(movie)).toList();
    }
    else{
      throw Exception("Failed to get movies result");
    }
  }
  Future<List<CastModel>> getCastsByMovieId(int movieId) async {
    var response = await dioHelper.getData(path: ApiConstants.movieCreditsEndPoint1 + movieId.toString() + ApiConstants.movieCreditsEndPoint2, query: {"api_key":ApiConstants.apiKey});
    if(response.statusCode == 200 || response.statusCode == 304){
      List<dynamic> result = response.data["cast"];
      return result.map((cast)=>CastModel.fromJson(cast)).toList();
    }
    else{
      throw Exception("Failed to get casts");
    }
  }
  Future<List<MovieModel>> getSimilarMoviesById(int movieId) async {
    var response = await dioHelper.getData(path: ApiConstants.movieSimilarEndPoint1 + movieId.toString() + ApiConstants.movieSimilarEndPoint2, query: {"api_key":ApiConstants.apiKey});
    if(response.statusCode == 200 || response.statusCode == 304){
      List<dynamic> results = response.data["results"];
      return results.map((movie)=>MovieModel.fromJson(movie)).toList();
    }
    else{
      throw Exception("Failed to get similar movies");
    }
  }

  Future<String> getMovieCertification(int movieId) async {
    var response = await dioHelper.getData(
        path: ApiConstants.movieCertificateEndPoint1 + movieId.toString() + ApiConstants.movieCertificateEndPoint2,
        query: {"api_key": ApiConstants.apiKey}
    );

    if (response.statusCode == 200 || response.statusCode == 304) {
      List results = response.data["results"];
      // Find the US rating as a default
      var usRating = results.firstWhere((e) => e["iso_3166_1"] == "US", orElse: () => results.first);

      List<dynamic> usCertifications = usRating["release_dates"];

      var usCertification = usCertifications.firstWhere((cert) => (cert["certification"] != "") , orElse: ()=> {"certification" : "G"});

      return usCertification["certification"];
    }
    else{
      throw Exception("Failed to load movie certification");
    }
  }

}
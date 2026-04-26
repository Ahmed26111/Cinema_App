import 'dart:developer';

import 'package:cinema_app/constants/api%20constants/api_constants.dart';
import 'package:cinema_app/data/models/cast_model.dart';
import 'package:cinema_app/data/models/details_movie_model.dart';
import 'package:cinema_app/data/models/movie_model.dart';
import 'package:cinema_app/data/services/dio_helper.dart';

class MovieRepository{
  final DioHelper dioHelper;

  MovieRepository({required this.dioHelper});

  Future<List<MovieModel>> getPopularMovies() async {
    var response = await dioHelper.getData(path: ApiConstants.moviePopularEndPoint , query: {"api_key":ApiConstants.apiKey});
    if(response.statusCode == 200){
      List<dynamic> results = response.data["results"];
      return results.map((movie)=>MovieModel.fromJson(movie)).toList();
    }
    else{
      throw Exception("Failed to get the popular movies");
    }
  }
  Future<List<MovieModel>> getTopRatedMovies() async {
    var response = await dioHelper.getData(path: ApiConstants.movieTopRatedEndPoint, query: {"api_key":ApiConstants.apiKey});
    if(response.statusCode == 200){
      List<dynamic> results = response.data["results"];
      return results.map((movie)=>MovieModel.fromJson(movie)).toList();
    }
    else{
      throw Exception("Failed to get the top rated movies");
    }
  }
  Future<List<MovieModel>> getUpComingMovies() async {
    var response = await dioHelper.getData(path: ApiConstants.movieUpComingEndPoint, query: {"api_key":ApiConstants.apiKey});
    if(response.statusCode == 200){
      List<dynamic> results = response.data["results"];
      return results.map((movie)=>MovieModel.fromJson(movie)).toList();
    }
    else{
      throw Exception("Failed to get the upcoming movies");
    }
  }
  Future<DetailsMovieModel> getDetailsMovieById(int movieId) async {
      var response = await dioHelper.getData(path: ApiConstants.movieIdEndPoint + movieId.toString(), query: {"api_key":ApiConstants.apiKey});
      if(response.statusCode == 200){
        dynamic result = response.data;
        return DetailsMovieModel.fromJson(result);
      }
      else{
        throw Exception("Failed to get movie details");
      }
  }
  Future<List<MovieModel>> getMoviesBySearch(String searchQuery) async {
    var response = await dioHelper.getData(path: ApiConstants.searchMovieEndPoint, query: {"api_key":ApiConstants.apiKey , "query":searchQuery});
    if(response.statusCode == 200){
      List<dynamic> results = response.data["results"];
      return results.map((movie)=>MovieModel.fromJson(movie)).toList();
    }
    else{
      throw Exception("Failed to get movies result");
    }
  }
  Future<List<CastModel>> getCastsByMovieId(int movieId) async {
    var response = await dioHelper.getData(path: ApiConstants.movieCreditsEndPoint1 + movieId.toString() + ApiConstants.movieCreditsEndPoint2, query: {"api_key":ApiConstants.apiKey});
    if(response.statusCode == 200){
      List<dynamic> result = response.data["cast"];
      return result.map((cast)=>CastModel.fromJson(cast)).toList();
    }
    else{
      throw Exception("Failed to get casts");
    }
  }
  Future<List<MovieModel>> getSimilarMoviesById(int movieId) async {
    var response = await dioHelper.getData(path: ApiConstants.movieSimilarEndPoint1 + movieId.toString() + ApiConstants.movieSimilarEndPoint2, query: {"api_key":ApiConstants.apiKey});
    if(response.statusCode == 200){
      List<dynamic> results = response.data["results"];
      return results.map((movie)=>MovieModel.fromJson(movie)).toList();
    }
    else{
      throw Exception("Failed to get similar movies");
    }
  }
}
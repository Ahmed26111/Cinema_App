import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiConstants{
  //* movieCreditsEndPoint1 + movieID + movieCreditsEndPoint2 => to get the end point of movieCredits
  //* movieSimilarEndPoint1 + movieID + movieSimilarEndPoint2 => to get the end point of movieSimilar

  static final String baseImageUrl = dotenv.env['BaseImageUrl'] ?? "";
  static final String baseUrl = dotenv.env['BaseUrl'] ?? "";
  static final String moviePopularEndPoint = "/movie/popular";
  static final String movieTopRatedEndPoint = "/movie/top_rated";
  static final String movieUpComingEndPoint = "/movie/upcoming";
  static final String movieIdEndPoint = "/movie/"; //* need to be concatenated with id
  static final String searchMovieEndPoint = "/search/movie";
  static final String movieCreditsEndPoint1 = "/movie/";
  static final String movieCreditsEndPoint2 = "/credits";
  static final String movieSimilarEndPoint1 = "/movie/";
  static final String movieSimilarEndPoint2 = "/similar";
  static final String apiKey = dotenv.env['Api_key'] ?? "";
}
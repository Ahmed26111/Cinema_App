import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiConstants{
  //* movieCreditsEndPoint1 + movieID + movieCreditsEndPoint2 => to get the end point of movieCredits
  //* movieSimilarEndPoint1 + movieID + movieSimilarEndPoint2 => to get the end point of movieSimilar

  static final String baseImageUrl = dotenv.env['BaseImageUrl'] ?? "";
  static final String baseUrl = dotenv.env['BaseUrl'] ?? "";
  static final String moviePopularEndPoint = dotenv.env['MoviePopularEndPoint'] ?? "";
  static final String movieTopRatedEndPoint = dotenv.env['MovieTopRatedEndPoint'] ?? "";
  static final String movieUpComingEndPoint = dotenv.env['MovieUpComingEndPoint'] ?? "";
  static final String movieIdEndPoint = dotenv.env['MovieIdEndPoint'] ?? ""; //* need to be concatenated with id
  static final String searchMovieEndPoint = dotenv.env['SearchMovieEndPoint'] ?? "";
  static final String movieCreditsEndPoint1 = dotenv.env['MovieCreditsEndPoint1'] ?? "";
  static final String movieCreditsEndPoint2 = dotenv.env['MovieCreditsEndPoint2'] ?? "";
  static final String movieSimilarEndPoint1 = dotenv.env['MovieSimilarEndPoint1'] ?? "";
  static final String movieSimilarEndPoint2 = dotenv.env['MovieSimilarEndPoint2'] ?? "";
  static final String apiKey = dotenv.env['Api_key'] ?? "";
}
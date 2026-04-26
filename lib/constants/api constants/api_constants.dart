abstract class ApiConstants{
  //* movieCreditsEndPoint1 + movieID + movieCreditsEndPoint2 => to get the end point of movieCredits
  //* movieSimilarEndPoint1 + movieID + movieSimilarEndPoint2 => to get the end point of movieSimilar

  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String moviePopularEndPoint = "/movie/popular";
  static const String movieTopRatedEndPoint = "/movie/top_rated";
  static const String movieUpComingEndPoint = "/movie/upcoming";
  static const String movieIdEndPoint = "/movie/"; //* need to be concatenated with id
  static const String searchMovieEndPoint = "/search/movie";
  static const String movieCreditsEndPoint1 = "/movie/";
  static const String movieCreditsEndPoint2 = "/credits";
  static const String movieSimilarEndPoint1 = "/movie/";
  static const String movieSimilarEndPoint2 = "/similar";
  static const String apiKey = "8ca6e9d39251b1c1709e16cc63fe54d2";
}
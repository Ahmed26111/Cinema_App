import 'package:cinema_app/constants/movie%20genre%20enum/movie_genre_enum.dart';
import 'package:date_format/date_format.dart';

abstract class Conversion {
  static DateTime convertStringToDateTime(String date) {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(date);
    } on FormatException catch (e) {
      dateTime = DateTime.now();
    }
    return dateTime;
  }

  static String today() {
    return formatDate(DateTime.now(), [yyyy, "-", mm, "-", dd]);
  }

  static String getGenreNameByGenreId(int genreId){
    final MovieGenreEnum genreEnum = MovieGenreEnum.values.firstWhere((genre)=>(genre.genreID == genreId) , orElse: ()=>MovieGenreEnum.All);
    return (genreEnum == MovieGenreEnum.All)?"Unknown":genreEnum.name;
  }

}

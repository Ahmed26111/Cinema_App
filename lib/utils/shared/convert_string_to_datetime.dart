abstract class Conversion{
  static DateTime convertStringToDateTime(String date) {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(date);
    }on FormatException catch(e){
      dateTime = DateTime.now();
    }
    return dateTime;
  }


}

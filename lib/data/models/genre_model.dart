import 'package:cinema_app/constants/api%20constants/genre_key_constants.dart';

class GenreModel {
  final int id;
  final String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json[GenreKeyConstants.id],
      name: json[GenreKeyConstants.name],
    );
  }
}

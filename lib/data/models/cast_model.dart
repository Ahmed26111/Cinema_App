import 'package:cinema_app/constants/api%20constants/cast_key_constants.dart';

class CastModel {
  final int gender;
  final int castId;
  final String name;
  final String characterName;
  final String? profileImagePath;
  final int orderInList;

  CastModel({
    required this.gender,
    required this.castId,
    required this.name,
    required this.characterName,
    required this.profileImagePath,
    required this.orderInList,
  });

  factory CastModel.fromJson(Map<String, dynamic>json){
    return CastModel(
        gender: json[CastKeyConstants.gender],
        castId: json[CastKeyConstants.castId],
        name: json[CastKeyConstants.name],
        characterName: json[CastKeyConstants.characterName],
        profileImagePath: json[CastKeyConstants.profileImagePath],
        orderInList: json[CastKeyConstants.order],
    );
  }

}

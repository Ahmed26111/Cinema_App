import 'package:cinema_app/constants/api%20constants/company_key_constants.dart';

class CompanyModel {
  final int companyId;
  final String companyName;
  final String originCountry;
  final String? logoImagePath;

  CompanyModel({
    required this.companyId,
    required this.companyName,
    required this.originCountry,
    required this.logoImagePath,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json){
    return CompanyModel(
        companyId: json[CompanyKeyConstants.id],
        companyName: json[CompanyKeyConstants.name],
        originCountry: json[CompanyKeyConstants.originCountry],
        logoImagePath: json[CompanyKeyConstants.logoPath]
    );
  }
}

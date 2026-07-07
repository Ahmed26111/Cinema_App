import 'package:cinema_app/data/models/company/company_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CompanyAdapter extends TypeAdapter<CompanyModel> {
  @override
  CompanyModel read(BinaryReader reader) {
    return CompanyModel(
        companyId: reader.readInt(),
        companyName: reader.readString(),
        originCountry: reader.readString(),
        logoImagePath: reader.readString(),
    );
  }

  @override
  int get typeId => 4;

  @override
  void write(BinaryWriter writer, CompanyModel obj) {
    writer.writeInt(obj.companyId);
    writer.writeString(obj.companyName);
    writer.writeString(obj.originCountry);
    writer.writeString(obj.logoImagePath ?? "");
  }

}
import 'package:control_system/Data/Models/school/school_type/school_type_model.dart';


class SchoolTypeSubjectsResModel {

  SchoolTypeResModel? schoolType;

  SchoolTypeSubjectsResModel({
    this.schoolType,
  });
  SchoolTypeSubjectsResModel.fromJson(json) {
    schoolType = json['school_type'] != null
        ? SchoolTypeResModel.fromJson(json['school_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (schoolType != null) {
      data['school_type'] = schoolType!.toJson();
    }
    return data;
  }
}

import '../school_type/school_type_model.dart';

class SchoolResModel {
  SchoolResModel({
    this.iD,
    this.schoolTypeID,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.active,
    this.schoolType,
  });

  factory SchoolResModel.fromJson(json) => SchoolResModel(
        iD: json['ID'],
        schoolTypeID: json['School_Type_ID'],
        name: json['Name'],
        createdBy: json['Created_By'],
        createdAt: json['Created_At'],
        updatedBy: json['Updated_By'],
        updatedAt: json['Updated_At'],
        active: json['Active'],
        schoolType: json['school_type'] != null
            ? SchoolTypeResModel.fromJson(json['school_type'])
            : null,
      );

  int? active;
  DateTime? createdAt;
  int? createdBy;
  int? iD;
  String? name;
  SchoolTypeResModel? schoolType;
  int? schoolTypeID;
  DateTime? updatedAt;
  int? updatedBy;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['School_Type_ID'] = schoolTypeID;
    data['Name'] = name;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    data['Updated_By'] = updatedBy;
    data['Updated_At'] = updatedAt;
    data['Active'] = active;
    if (schoolType != null) {
      data['school_type'] = schoolType!.toJson();
    }
    return data;
  }
}

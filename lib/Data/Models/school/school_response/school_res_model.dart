import '../school_type/school_type_model.dart';

class SchoolResModel {
  int? iD;
  int? schoolTypeID;
  String? name;
  int? createdBy;
  DateTime? createdAt;
  int? updatedBy;
  DateTime? updatedAt;
  int? active;
  SchoolType? schoolType;

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

  SchoolResModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    schoolTypeID = json['School_Type_ID'];
    name = json['Name'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
    active = json['Active'];
    schoolType = json['school_type'] != null
        ? SchoolType.fromJson(json['school_type'])
        : null;
  }

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
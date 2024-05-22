class CohortResModel {
  int? iD;
  int? schoolTypeID;
  String? name;
  int? createdBy;
  String? createdAt;
  Null updatedBy;
  Null updatedAt;
  int? active;

  CohortResModel({
    this.iD,
    this.schoolTypeID,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.active,
  });

  CohortResModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    schoolTypeID = json['School_Type_ID'];
    name = json['Name'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
    active = json['Active'];
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
    return data;
  }
}

class ControlMissionResModel {
  int? iD;
  int? educationYearID;
  int? schoolsID;
  String? name;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  String? startDate;
  String? endDate;
  int? active;

  ControlMissionResModel({
    this.iD,
    this.educationYearID,
    this.schoolsID,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedBy,
    this.updatedAt,
    this.startDate,
    this.endDate,
    this.active,
  });

  ControlMissionResModel.fromJson(json) {
    iD = json['ID'];
    educationYearID = json['Education_year_ID'];
    schoolsID = json['Schools_ID'];
    name = json['Name'];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
    startDate = json['Start_Date'];
    endDate = json['End_Date'];
    active = json['Active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Education_year_ID'] = educationYearID;
    data['Schools_ID'] = schoolsID;
    data['Name'] = name;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    data['Updated_By'] = updatedBy;
    data['Updated_At'] = updatedAt;
    data['Start_Date'] = startDate;
    data['End_Date'] = endDate;
    data['Active'] = active;
    return data;
  }
}

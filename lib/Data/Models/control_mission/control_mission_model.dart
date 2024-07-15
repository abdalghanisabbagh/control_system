class ControlMissionResModel {
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
    this.count,
  });

  ControlMissionResModel.fromExtra(Map<String, String>? extra) {
    iD = int.parse(extra?['ID'] ?? '0');
    educationYearID = int.parse(extra?['Education_year_ID'] ?? '0');
    schoolsID = int.parse(extra?['Schools_ID'] ?? '0');
    name = extra?['Name'];
    createdBy = int.parse(extra?['Created_By'] ?? '0');
    createdAt = extra?['Created_At'];
    updatedBy = int.parse(extra?['Updated_By'] ?? '0');
    updatedAt = extra?['Updated_At'];
    startDate = extra?['Start_Date'];
    endDate = extra?['End_Date'];
    active = int.parse(extra?['Active'] ?? '0');
  }

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
    count = json['_count'];
  }

  int? active;
  String? createdAt;
  int? createdBy;
  int? educationYearID;
  String? endDate;
  int? iD;
  String? name;
  int? schoolsID;
  String? startDate;
  String? updatedAt;
  int? updatedBy;
  Map<String, dynamic>? count;

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

  Map<String, String>? toExtra() {
    return {
      'ID': iD.toString(),
      'Education_year_ID': educationYearID.toString(),
      'Schools_ID': schoolsID.toString(),
      'Name': name ?? '',
      'Created_By': createdBy.toString(),
      'Created_At': createdAt ?? '',
      'Updated_By': updatedBy.toString(),
      'Updated_At': updatedAt ?? '',
      'Start_Date': startDate ?? '',
      'End_Date': endDate ?? '',
      'Active': active.toString(),
    };
  }
}

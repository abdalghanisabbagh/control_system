class ControlMissionModel {
  ControlMissionModel({
    this.educationYearID,
    this.schoolsID,
    this.name,
  });

  ControlMissionModel.fromJson(Map<String, dynamic> json) {
    educationYearID = json['Education_year_ID'];
    schoolsID = json['Schools_ID'];
    name = json['Name'];
  }

  int? educationYearID;
  String? name;
  int? schoolsID;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Education_year_ID'] = educationYearID;
    data['Schools_ID'] = schoolsID;
    data['Name'] = name;
    return data;
  }
}

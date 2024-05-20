import 'package:control_system/Data/Models/base_model.dart';

class ControlMessionModel extends BaseModel {
  int? educationYearID;
  int? schoolsID;
  String? name;

  ControlMessionModel({
    this.educationYearID,
    this.schoolsID,
    this.name,
  });

  ControlMessionModel.fromJson(Map<String, dynamic> json) {
    educationYearID = json['Education_year_ID'];
    schoolsID = json['Schools_ID'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Education_year_ID'] = educationYearID;
    data['Schools_ID'] = schoolsID;
    data['Name'] = name;
    return data;
  }
}

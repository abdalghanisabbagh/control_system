import '../../base_model.dart';

class SchoolResponseModel extends BaseModel {
  int? iD;
  int? schoolTypeID;
  String? name;

  SchoolResponseModel({
    this.iD,
    this.schoolTypeID,
    this.name,
  });

  SchoolResponseModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    schoolTypeID = json['School_Type_ID'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['School_Type_ID'] = schoolTypeID;
    data['Name'] = name;
    return data;
  }
}

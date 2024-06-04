class EducationYearModel {
  EducationYearModel({this.name});

  EducationYearModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    id = json['ID'];
  }

  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['ID'] = id;
    return data;
  }
}

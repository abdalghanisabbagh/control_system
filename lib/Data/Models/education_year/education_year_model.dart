class EducationYearModel {
  int? id;

  String? name;

  EducationYearModel({this.name});
  EducationYearModel.fromJson(json) {
    name = json['Name'];
    id = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['ID'] = id;
    return data;
  }
}

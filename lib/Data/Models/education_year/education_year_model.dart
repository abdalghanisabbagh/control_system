class EducationYearModel {
  String? name;

  EducationYearModel({this.name});

  EducationYearModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    return data;
  }
}

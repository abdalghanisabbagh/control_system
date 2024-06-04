import 'education_year_model.dart';

class EducationsYearsModel {
  EducationsYearsModel({this.data});

  EducationsYearsModel.fromJson(json) {
    data = List<EducationYearModel>.from(
        json.map((e) => EducationYearModel.fromJson(e)).toList());
  }

  List<EducationYearModel>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

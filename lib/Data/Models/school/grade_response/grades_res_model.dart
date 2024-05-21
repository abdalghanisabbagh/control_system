import 'grade_res_model.dart';

class GradesResModel {
  List<GradeResModel>? data;

  GradesResModel({this.data});

  GradesResModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GradeResModel>[];
      json['Grades'].forEach((v) {
        data!.add(GradeResModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

import 'grade_res_model.dart';

class GradesResModel {
  List<GradeResModel>? data;

  GradesResModel({this.data});

  GradesResModel.fromJson(json) {
    data = List<GradeResModel>.from(
        json.map((e) => GradeResModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

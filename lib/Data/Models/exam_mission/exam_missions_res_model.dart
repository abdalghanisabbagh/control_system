import 'exam_mission_res_model.dart';

class ExamMissionsResModel {
  ExamMissionsResModel({this.data});

  ExamMissionsResModel.fromJson(json) {
    data = List<ExamMissionResModel>.from(
        json.map((e) => ExamMissionResModel.fromJson(e)).toList());
  }

  List<ExamMissionResModel>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

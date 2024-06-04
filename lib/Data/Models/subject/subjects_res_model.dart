import 'subject_res_model.dart';

class SubjectsResModel {
  SubjectsResModel({this.data});

  SubjectsResModel.fromJson(json) {
    data = List<SubjectResModel>.from(
        json.map((e) => SubjectResModel.fromJson(e)).toList());
  }

  List<SubjectResModel>? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

import 'subject_res_model.dart';

class SubjectsResModel {
  List<SubjectResModel>? data;

  SubjectsResModel({this.data});

  SubjectsResModel.fromJson(json) {
    data = List<SubjectResModel>.from(
        json.map((e) => SubjectResModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

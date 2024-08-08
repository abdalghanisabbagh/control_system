import 'school_type_has_subjects_res_model.dart';

class SubjectResModel {
  int? active, inExam;

  String? createdAt;

  int? createdBy;
  int? iD;
  String? name;
  String? updatedAt;
  int? updatedBy;
  SchoolTypeHasSubjectsResModel? schoolTypeHasSubjectsResModel;

  SubjectResModel(
      {this.iD,
      this.name,
      this.active,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.schoolTypeHasSubjectsResModel,
      this.inExam});
  SubjectResModel.fromJson(json) {
    iD = json['ID'];
    name = json['Name'];
    active = json['Active'];
    inExam = json["InExam"];
    createdBy = json['Created_By'];
    createdAt = json['Created_At'];
    updatedBy = json['Updated_By'];
    updatedAt = json['Updated_At'];
    schoolTypeHasSubjectsResModel = json['school_type_has_subjects'] == null
        ? null
        : SchoolTypeHasSubjectsResModel.fromJson(
            json['school_type_has_subjects']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['Active'] = active;
    data['Created_By'] = createdBy;
    data['Created_At'] = createdAt;
    data['Updated_By'] = updatedBy;
    data['Updated_At'] = updatedAt;
    if (schoolTypeHasSubjectsResModel != null) {
      data['school_type_has_subjects'] =
          schoolTypeHasSubjectsResModel!.toJson();
    }
    data["InExam"] = inExam;
    return data;
  }
}

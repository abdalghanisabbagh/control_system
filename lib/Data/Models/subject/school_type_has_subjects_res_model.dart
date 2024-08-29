import 'school_type_subjects_res_model.dart';

class SchoolTypeHasSubjectsResModel {
  List<SchoolTypeSubjectsResModel>? schooltypeHasSubjects;

  SchoolTypeHasSubjectsResModel({this.schooltypeHasSubjects});

  SchoolTypeHasSubjectsResModel.fromJson(json) {
    schooltypeHasSubjects = List<SchoolTypeSubjectsResModel>.from(
        json.map((e) => SchoolTypeSubjectsResModel.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (schooltypeHasSubjects != null) {
      data['school_type_has_subjects'] =
          schooltypeHasSubjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

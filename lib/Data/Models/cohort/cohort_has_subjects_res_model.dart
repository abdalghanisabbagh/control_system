import '../subject/subject_res_model.dart';

class CohortHasSubjectsResModel {
  int? cohortID;

  SubjectResModel? subjects;

  int? subjectsID;
  CohortHasSubjectsResModel({
    this.cohortID,
    this.subjectsID,
    this.subjects,
  });
  CohortHasSubjectsResModel.fromJson(json) {
    cohortID = json['Cohort_ID'];
    subjectsID = json['Subjects_ID'];
    subjects = json['subjects'] != null
        ? SubjectResModel.fromJson(json['subjects'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Cohort_ID'] = cohortID;
    data['Subjects_ID'] = subjectsID;
    if (subjects != null) {
      data['subjects'] = subjects!.toJson();
    }
    return data;
  }
}
